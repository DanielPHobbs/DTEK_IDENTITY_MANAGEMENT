
# Load FIMAutomation module
if(@(Get-PSSnapin | ? { $_.Name -eq "FIMAutomation" } ).Count -eq 0)
{
    Add-PSSnapin FIMAutomation;
}

########################################################################################################################
###
### FIM_Support-DeleteSynchronizationRule
######
### PURPOSE: Designed to locate a Synchronization Rule based on DisplayName and/or the ResourceID of the Synchronization Rule
### PARAMETERS:
### $URI = FIM Web Service Address and port ( e.g. http://myfimservice Jump :5725 )
### $GETDISPLAYNAME = Synchronization Rule Display Name of the Synchronization Rule you wish to delete
### $TARGETIDENTIFIER = ResourceID of the Synchronization Rule you wish to delete
###
########################################################################################################################
$URI = "http://mim.dtekuk.com:5725/"
#$GETDISPLAYNAME="DTEKUK FileMA Inbound Synchronization Rule"
$GETDISPLAYNAME="DTEKUK E2 HR inbound synchronization rule"
$TARGETIDENTIFIER ="21b9b132-4162-4c97-bd8c-a833ce5dc076"


$uri = $uri+"/resourcemanagementservice"
$exportData = export-fimconfig -uri $uri -customconfig ("/SynchronizationRule") -onlyBaseResources
 
$exportData | ForEach-Object{
$displayName = ($_.ResourceManagementObject.ResourceManagementAttributes | `
Where-Object {$_.AttributeName -eq "DisplayName"}).Value
if($displayName -eq $GetDisplayName){
     $TargetIdentifier = ((($_.ResourceManagementObject.ResourceManagementAttributes |
Where-Object {$_.AttributeName -eq "ObjectID"}).Value).Split(":"))[2]
   }
 
$importObject = New-Object Microsoft.ResourceManagement.Automation.ObjectModel.ImportObject
$importObject.ObjectType = "SynchronizationRule"
$importObject.TargetObjectIdentifier = $TargetIdentifier
$importObject.SourceObjectIdentifier = $TargetIdentifier
$importObject.State = 2
$importObject | Import-FIMConfig -uri $uri -ErrorAction SilentlyContinue
}
