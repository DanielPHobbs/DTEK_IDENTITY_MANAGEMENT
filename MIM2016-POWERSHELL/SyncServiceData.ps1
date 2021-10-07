$LogFile ="E:\logs\fimdata.txt"
$FIMServer = get-wmiobject -Namespace "root\MicrosoftIdentityIntegrationServer" -class "MIIS_Server"
$FIMMAs = get-wmiobject -Namespace "root\MicrosoftIdentityIntegrationServer" -class "MIIS_ManagementAgent"
$FIMRunHistory = get-wmiobject -Namespace "root\MicrosoftIdentityIntegrationServer" -class "MIIS_RunHistory"

Function WriteLog
{
    PARAM($Message)
    END
    {
        write-host $Message
        $Message | Add-Content $LogFile
    }
}

Out-File -FilePath $LogFile -Encoding "Default"

foreach ($MA in $FIMMAs)
{
    WriteLog ($MA.Name)
    WriteLog ("Type: " + $MA.Type)
    WriteLog ("Connector Space:")
    WriteLog ("`tCSObjects: " + $MA.NumCSObjects().ReturnValue)
    WriteLog ("`t`tConnectors: " + $MA.NumTotalConnectors().ReturnValue)
    WriteLog ("`t`t`tManual Joins: " + $MA.NumExplicitConnectors().ReturnValue)
    WriteLog ("`t`tDisconnectors: " + $MA.NumTotalDisconnectors().ReturnValue)
    WriteLog ("`t`t`tExplicit Disconnectors: " + $MA.NumExplicitDisconnectors().ReturnValue)
    WriteLog ("`t`t`tFiltered Disconnectors: " + $MA.NumFilteredDisconnectors().ReturnValue)
    WriteLog ("`t`tPlaceholders: " + $MA.NumPlaceholders().ReturnValue)
    WriteLog ("`tPendingExports:")
    WriteLog ("`t`tAdds: " + $MA.NumExportAdd().ReturnValue)
    WriteLog ("`t`tDeletes: " + $MA.NumExportDelete().ReturnValue)
    WriteLog ("`t`tUpdates: " + $MA.NumExportUpdate().ReturnValue)
    WriteLog ("`n")
    WriteLog ("Run History:")
    $rh = $FIMRunHistory | where {$_.MaName -eq $MA.Name}
    foreach ($run in $rh) { WriteLog ("`t" + $run.RunProfile + " " + $run.RunStartTime + " " + $run.RunStatus) }
    WriteLog ("`n")
    WriteLog ("`tLast Run Errors:")
    [xml]$rd = $MA.RunDetails().ReturnValue
    $ImportErrors = $rd."run-history"."run-details"."step-details"."synchronization-errors"."import-error"
    WriteLog ("`tError`tDN`tSince")
    foreach ($importErr in $ImportErrors) { WriteLog ("`t" + $importErr."error-type" + " " + $importErr."dn" + " " + $importErr."first-occurred") }
    WriteLog ("`n")
    WriteLog ("`n")
}