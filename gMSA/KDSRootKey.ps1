Add-KdsRootKey -EffectiveTime ((get-date).addhours(-10))

Get-KdsRootKey  

Test-KdsRootKey -KeyId '13956ed1-0832-27e1-0c5d-351861d739fb'




New-ADServiceAccount -Name 'SCO19_gMSA' -DNSHostName 'SCO19_gMSA.dtek.com' -ManagedPasswordIntervalInDays 75

Set-ADServiceAccount -Identity 'SCO19_gMSA' -PrincipalsAllowedToRetrieveManagedPassword 'SG-SCOM19_gMSA'

Set-ADServiceAccount -Identity 'SCO19_gMSA' -PrincipalsAllowedToRetrieveManagedPassword 'DTEKAZMON-MS2$'




#Modifying a Group Managed Service Account

Get-ADServiceAccount [-Name] '<string>' -PrincipalsAllowedToRetrieveManagedPassword

Set-ADServiceAccount [-Name] '<string>' -PrincipalsAllowedToRetrieveManagedPassword <ADPrincipal[]>




#Steps to Use for SCOM
#https://docs.microsoft.com/en-us/system-center/scom/support-group-managed-service-accounts?view=sc-om-2019




#------------------------------Install on Server ---------------------

Install-WindowsFeature RSAT-AD-PowerShell
Import-Module ActiveDirectory

Install-ADServiceAccount  SCO19_gMSA

Get-ADServiceAccount SCO19_gMSA -properties * | Format-List

Test-ADServiceAccount 'SCO19_gMSA'
