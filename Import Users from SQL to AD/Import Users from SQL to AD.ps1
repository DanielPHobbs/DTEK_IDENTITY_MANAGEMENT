Import-Module Adaxes

$databaseHost = "host.company.com" # TODO: modify me
$databaseName = "MyDatabase" # TODO: modify me
$databaseUsername = $NULL # TODO: modify me
$databasePassword = $NULL # TODO: modify me
# If set to $NULL, the credentials of the Adaxes service
# account will be used to connect to the database

$propertyMap = @{
    "employeeID" = "ID";
    "name" = "Name";
    "samaccountname" = "Username";
    "givenName" = "FirstName";
    "sn" = "LastName";
    "displayName" = "DisplayName";
    "description" = "Description";
    "unicodePwd" = "Password";
    "department" = "Department";
    "company" = "Company";
    "l" = "City";
    "postOfficeBox" = "Office";
    "AccountExpires" = "AccountExpiresDate";
} # TODO: modify me: $propertyMap = @{"LdapPropertyName" = "SQL database field"}

$commandText = "SELECT ID,Name,Username,FirstName,LastName,DisplayName,Description,Password,Department,Company,City,Office,AccountExpiresDate FROM UsersTable" 
# TODO: modify me

# Connect to the database
$connectionString = "Data Source=$databaseHost; Initial Catalog=$databaseName;"
if ($databaseUsername -eq $NULL)
{
    $connectionString = $connectionString +
        "Integrated Security=SSPI;"
}
else
{
    $connectionString = $connectionString +
        "User ID=$databaseUsername;Password=$databasePassword;"
}

try
{
    $connection = New-Object "System.Data.SqlClient.SqlConnection"  $connectionString
    $connection.Open()
    
    # Query user information from database
    $command = $connection.CreateCommand()
    $command.CommandText = $commandText

    # Load user information
    $reader = $command.ExecuteReader()
    $usersFromDB = @{}

    while ($reader.Read())
    {
        $valuesFromDB = @{}
        foreach ($ldapPropertyName in $propertyMap.Keys)
        {
            $columnName = $propertyMap[$ldapPropertyName]
            $value = $reader[$columnName]

            # If the value is empty, skip it
            if ([System.String]::IsNullOrEmpty($value) -or ([System.Convert]::IsDBNull($value)))
            {
                continue
            }
            elseif ($value -is [System.String])
            {
                $value = $value.Trim()
            }
            elseif ($ldapPropertyName -ieq "accountExpires")
            {
                try
                {
                    $value = $value.ToFileTime() # Convert Date to Large Integer
                }
                catch
                {
                    continue
                }
            }
            if ($value -ieq "True" -or $value -ieq "False")
            {
                $value = [System.Boolean]::Parse($property.Value)
            }

            $valuesFromDB.Add($ldapPropertyName, $value)
        }
        $usersFromDB.Add($valuesFromDB.employeeID, $valuesFromDB)
    }
}
finally
{
    # Close connection to the SQL database and release resources
    if ($reader) { $reader.Close() }
    if ($command) { $command.Dispose() }
    if ($connection) { $connection.Close() }
}

# Get domain name
$domainName = $Context.GetObjectDomain("%distinguishedName%")

foreach ($employeeId in $usersFromDB.Keys)
{
    $userPropertiesFromDB = $usersFromDB[$employeeId]

    # Get User Password, and remove it from the hashtable
    $userPassword = ConvertTo-SecureString -AsPlainText -String $userPropertiesFromDB["unicodePwd"] -Force
    $userPropertiesFromDB.Remove("unicodePwd")

    # Get other properties
    $propertiesToCheck = @($userPropertiesFromDB.Keys)
    
    # Search user by Employee Number
    $user = Get-AdmUser -Filter {employeeId -eq $employeeId} -AdaxesService localhost -Server $domainName `
        -Properties $propertiesToCheck -ErrorAction SilentlyContinue
        
    if ($NULL -eq $user)
    {
        # The user account does not exist, create one
        # Get user identity, and remove it from the hashtable
        $name = $userPropertiesFromDB["name"]
        $userPropertiesFromDB.Remove("name")
        
        # Create user
        try
        {
            $user = New-AdmUser -Name $name -OtherAttributes $userPropertiesFromDB -AdaxesService localhost `
                -Server $domainName -Path "%distinguishedName%" -Enabled $True -ErrorAction Stop -PassThru
        }
        catch
        {
            $Context.LogMessage($_.Exception.Message, "Error")
            continue
        }
        
        if ($userPassword -ne $NULL)
        {
            # Set password
            Set-AdmAccountPassword -Identity $user.DistinguishedName -NewPassword $userPassword `
                -Reset -Server $domainName -AdaxesService localhost
        }
        
        continue
    }

    # If the user exists, check whether any properties have changed
    foreach ($propetyName in $propertiesToCheck)
    {
        # Remove properties with the same values from the hashtable
        if ($user."$propetyName" -ieq $userPropertiesFromDB[$propetyName])
        {
            $userPropertiesFromDB.Remove($propetyName)
        }
    }

    if ($userPropertiesFromDB.Count -eq 0)
    {
        continue # Nothing changed
    }

    # Update user
    Set-AdmUser $user.DistinguishedName -Replace $userPropertiesFromDB -AdaxesService localhost `
        -Server $domainName
}