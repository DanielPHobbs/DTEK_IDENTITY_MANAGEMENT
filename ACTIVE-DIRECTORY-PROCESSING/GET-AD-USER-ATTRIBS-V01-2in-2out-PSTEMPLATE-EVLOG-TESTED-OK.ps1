
#----------------------------------------------------------------------
# Simple Creds for PSSESSION

$passwd = convertto-securestring -AsPlainText -Force -String $Secret
$creds = new-object -typename System.Management.Automation.PSCredential -argumentlist "dtek\SVC-RBACC01",$passwd

#----------------------------------------------------------------------

# Set script parameters from runbook data bus and Orchestrator global variables
# Define any inputs here and then add to the $argsArray and script block parameters below 

$DataBusInput1 = "dhobbs-adm"
$DataBusInput2 = "DTEK.COM"


#-----------------------------------------------------------------------

## Initialize result and trace variables
$ResultStatus = ""
$ErrorMessage = ""
$Trace = (Get-Date).ToString() + "`t" + "Runbook activity script started" + " `r`n"
$stopwatch = [System.Diagnostics.Stopwatch]::StartNew()
  
       
# Create argument array for passing data bus inputs to the external script session
$argsArray = @()
$argsArray += $DataBusInput1
$argsArray += $DataBusInput2

# This gets an available DC in domain
$DC=Get-ADDomainController -Discover -Domain "dtek.com"

#This gets an available DC in specific site
#$DC=Get-ADDomainController -Discover -Site "LondonHQ" -ForceDiscover

$Session = New-PSSession -ComputerName $DC -Credential $creds

# Invoke-Command used to start the script in the external session. Variables returned by script are then stored in the $ReturnArray variable
$ReturnArray = Invoke-Command -Session $Session -Argumentlist $argsArray -ScriptBlock {
    
    Param(
        [ValidateNotNullOrEmpty()]
        [string]$DataBusInput1,

        [ValidateNotNullOrEmpty()]
        [string]$DataBusInput2
    )

    # Define function to add entry to trace log variable
    function AppendLog ([string]$Message)
    {
        $script:CurrentAction = $Message
        $script:TraceLog += ((Get-Date).ToString() + "`t" + $Message + " `r`n")
    }

    # Set external session trace and status variables to defaults
    $ResultStatus = ""
    $ErrorMessage = ""
    $script:CurrentAction = ""
    $script:TraceLog = ""

    try 
    {
        # Add startup details to trace log
        AppendLog "Script now executing in external PowerShell version [$($PSVersionTable.PSVersion.ToString())] session in a [$([IntPtr]::Size * 8)] bit process"
        AppendLog "Running as user [$([Environment]::UserDomainName)\$([Environment]::UserName)] on host [$($env:COMPUTERNAME)]"
        AppendLog "Parameter values received: DataBusInput1=[$DataBusInput1]; DataBusInput2=[$DataBusInput2]"

        ##################################################### MAIN CODE ##################################################################
        ##################################################################################################################################
       
       
        AppendLog "Load Modules and Enviroment"
        Import-Module ActiveDirectory
        # test exception
        #Throw "Something went wrong in remote session"

        AppendLog "Getting User Attributes from Active Directory"
        
        $UserProperties=Get-ADUser -Identity $DataBusInput1  -Properties *
       
        $UserCanonicalName=$UserProperties.CanonicalName
        $Useraddress=$UserProperties.StreetAddress
        
        
        ###################################################################################################################################
        ###################################################################################################################################

        # Validate results and set return status
        AppendLog "Finished work, determining result"
        $EverythingWorked = $true
        if($EverythingWorked -eq $true)
        {
           $ResultStatus = "Success"
        }
        else
        {
            $ResultStatus = "Failed"
        }
    }
    catch
    {
        # Catch any errors thrown above here, setting the result status and recording the error message to return to the activity for data bus publishing
        $ResultStatus = "Failed"
        $ErrorMessage = $error[0].Exception.Message
        AppendLog "Exception caught during action [$script:CurrentAction]: $ErrorMessage"
    }
    finally
    {
        # Always do whatever is in the finally block. In this case, adding some additional detail about the outcome to the trace log for return
        if($ErrorMessage.Length -gt 0)
        {
            AppendLog "Exiting external session with result [$ResultStatus] and error message [$ErrorMessage]"
        }
        else
        {
            AppendLog "Exiting external session with result [$ResultStatus]"
        }
        
    }

    # Return an array of the results. Additional variables like "myCustomVariable" can be returned by adding them onto the array
    $resultArray = @()
    $resultArray += $ResultStatus
    $resultArray += $ErrorMessage
    $resultArray += $script:TraceLog
    $resultArray += $UserCanonicalName
    $resultArray += $UserAddress
    return  $resultArray  
     
}#End Invoke-Command

# Get the values returned from script session for publishing to data bus
$ResultStatus = $ReturnArray[0]
$ErrorMessage = $ReturnArray[1]
$Trace += $ReturnArray[2]
$UserCAN = $ReturnArray[3]
$UserADDR = $ReturnArray[4]

# Record end of activity script process
[int]$elapsedTime = $stopwatch.Elapsed.TotalMilliseconds
    $stopwatch.Stop()

# Close the external session
Remove-PSSession $Session


##LOGGING 
If($ResultStatus -eq "Success" ){
    $AlertNumber = 200
    $LogName = "ORCHESTRATOR"
    $EventSource ="SCORCH"
    $Trace += (Get-Date).ToString() + "`t" + "Script completed successfully in $elapsedTime Milliseconds" + " `r`n"
    
         Write-EventLog `
             -EventId $AlertNumber `
             -LogName $LogName `
             -Source $EventSource `
             -Message $Trace `
             -EntryType Information
} Else {
    $AlertNumber = 205
    $LogName = "ORCHESTRATOR"
    $EventSource ="SCORCH"
    $Trace += (Get-Date).ToString() + "`t" + "Script Failed in $elapsedTime Milliseconds" + " `r`n"

        
        Write-EventLog `
            -EventId $AlertNumber `
            -LogName $LogName `
            -Source $EventSource `
            -Message $Trace `
            -EntryType Error

            exit 1
}    

$UserCAN 
$UserADDR 


