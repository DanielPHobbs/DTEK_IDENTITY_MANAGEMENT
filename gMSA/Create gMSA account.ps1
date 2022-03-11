Import-module activedirectory
  
$gMSAName = 'gMSA_Account_Name' ## Replace this value with new gMSA Name
$serverList = 'Server001','Server002','Server003','Server004','Server005' ## Replace with Server Names
$adOU = 'ou=Managed Service Accounts,OU=Service Accounts,DC=your_company,DC=com' ## Replace with actual AD OU
  
## Checking whether organizational unit exists, if not create it.
$ous = dsquery ou "$adOU"
if ($ous.count -eq 0) {
    dsadd ou "$adOU"
}

## Create a Group Managed Service Account
$NameOfServersAccountIsToBeUsedOn = $serverList.ForEach{ return (Get-ADComputer $_)  }
Write-Output $NameOfServersAccountIsToBeUsedOn

##Creating the gMSA
New-ADServiceAccount -Name $gMSAName -Path "$adOU" -DNSHostName "$gMSAName.your_company.com" -PrincipalsAllowedToRetrieveManagedPassword $NameOfServersAccountIsToBeUsedOn -TrustedForDelegation $true

#-----------------------------------------------------------------------------------------------------------------------------
Import-module activedirectory
  
$gMSAName = 'gMSA_Account_Name' ## Replace this value with new gMSA Name

## Install the gMSA account in server
Install-ADServiceAccount -Identity $gMSAName

## Test gMSA account installation in Server
Test-AdServiceAccount $gMSAName