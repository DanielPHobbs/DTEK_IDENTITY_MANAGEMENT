<#
.SYNOPSIS
    Powershell Wrapper for Orchestrator runbook Powershell script 

.DESCRIPTION
  
.NOTES
   
#>


    # This saves the starting ErrorActionPreference and then sets it to 'Stop'.
    $startErrorActionPreference = $errorActionPreference
    $errorActionPreference = 'Stop'
    
    # This gets the current path and name of the script.
    $invocation = (Get-Variable MyInvocation).Value
    $scriptName = $invocation.MyCommand.Name
    $stopwatch = [System.Diagnostics.Stopwatch]::StartNew()
    $startTime = Get-Date

    $Message += "Script $scriptName started execution @  $startTime" 
    $Message += "`n" + "`n"
    $Message += "Script is Executing in PowerShell version [$($PSVersionTable.PSVersion.ToString())]  in a [$([IntPtr]::Size * 8)] bit process"
    $Message += "`n" + "`n"
    $Message += "Script Executing as User [$([Environment]::UserDomainName)\$([Environment]::UserName)] on host [$($env:COMPUTERNAME)]"


    try {

    #########################################################################################################################################

        Write-output "started Script Processing"
        #throw "this is an error"
        Import-Module ActiveDirectory
        
        $DC=Get-ADDomainController -Discover -Domain "dtek.com"
        
        Get-ADUser -Filter * -SearchBase "OU=AZURE,OU=DTEK USERS,DC=DTEK,DC=COM"

        Write-output "Ended Script Processing"

    #########################################################################################################################################
    # This resets the ErrorActionPreference to the starting value.
    $errorActionPreference = $startErrorActionPreference

    #Log Success - EventLog
    [int]$elapsedTime = $stopwatch.Elapsed.TotalMilliseconds
    $stopwatch.Stop()
 
    $Message += "`n" + "`n"
    $Message += "Script Executed Successfully in $elapsedTime Milliseconds"
 
    $AlertNumber = 200
    $LogName = "ORCHESTRATOR"
    $EventSource ="SCORCH"
         
         Write-EventLog `
             -EventId $AlertNumber `
             -LogName $LogName `
             -Source $EventSource `
             -Message $Message `
             -EntryType Information
 
    } catch {
        $errorMessage = "Script $scriptName started execution @  $startTime"
        $errorMessage += "`n" + "`n"
        $errorMessage += "Script was executed in PowerShell version [$($PSVersionTable.PSVersion.ToString())] in a [$([IntPtr]::Size * 8)] bit process"
        $errorMessage += "`n" + "`n"
        $errorMessage += "$scriptName caught an exception on $($ENV:COMPUTERNAME) Running as user [$([Environment]::UserDomainName)\$([Environment]::UserName)]:"
        $errorMessage += "`n" + "`n"
        $errorMessage += "Exception Type: $($_.Exception.GetType().FullName)"
        $errorMessage += "`n" + "`n"
        $errorMessage += "Exception Message: $($_.Exception.Message)"

        
        
    #Log error - EventLog

    
    $AlertNumber = 205
    $LogName = "ORCHESTRATOR"
    $EventSource ="SCORCH"
        
        Write-EventLog `
            -EventId $AlertNumber `
            -LogName $LogName `
            -Source $EventSource `
            -Message $errorMessage `
            -EntryType Error

            exit 1
    }


   