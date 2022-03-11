Add-KdsRootKey -EffectiveTime ((get-date).addhours(-10))

New-ADServiceAccount -Name '<ServiceName>' -DNSHostName '<DNS Hostname>' -ManagedPasswordIntervalInDays 75

Set-ADServiceAccount -Identity '<ServiceName>' -PrincipalsAllowedToRetrieveManagedPassword '<ServerName$>'



#------------------------------Install on Server ---------------------

Install-WindowsFeature RSAT-AD-PowerShell
Import-Module ActiveDirectory

Install-ADServiceAccount -Identity  '<ServiceName>'

Get-ADServiceAccount -Filter * | fl
