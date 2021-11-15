$Env:Path += ";C:\Program Files\hashicorp"



import-module "C:\Program Files\WindowsPowerShell\Modules\PSVault\1.0.1\PSVault.psm1"

get-command -Module PSVAULT

get-help -name set-VaultUnseal -detailed

#Install-Vault [[-VaultPath] <String>] [[-ConfigHcl] <String>] [[-Vaultversion] <String>] [[-ipadress] <String>] [[-StoragePath] <String>] [[-apiaddr] <String>] [[-FilePath] <String>] [[-encoding] <String>] [[-vaultZip] <String>] [-forceinstall] [[-ForceDownload] <Object>] [<CommonParameters>]

Install-Vault -VaultPath "c:\program files\hashicorp" -vaultversion 1.8.5 -apiaddr "http://10.10.10.75:8200"




$APIaddress = "http://10.10.10.75:8200"
$vaultpath = "c:\program files\hashicorp"


get-help -name Start-vault
#Start-Vault [-vaultpath] <Object> [-APIaddress] <Object> [[-UnsealKeys] <Array>] [[-Keycount] <Int32>] [[-autoInit] <Boolean>] [[-Unseal] <Boolean>] [-ReturnState] [[-WindowsStyle] <String>] [[-taskname] <Object>] [<CommonParameters>]

Start-vault -vaultpath "C:\Program Files\hashicorp"  -APIaddress "http://10.10.10.75:8200"  



get-help -name start-VaultInit

#start-VaultInit [-apiaddress] <Object> [-secret_shares <Object>] [-secret_threshold <Object>] [-ExportXML] -VaultPath <String> [-Exportfile <String>] [-Secure <Boolean>] [-AESKeyFile <String>] [<CommonParameters>]

start-VaultInit -apiaddress "http://10.10.10.75:8200"  -VaultPath "c:\program files\hashicorp" -Secure $true -ExportXML -AESKeyFile "c:\program files\hashicorp\config\AESKey.txt"


<#
UnsealKey1        : 5fabe762a619e70055d2e8617a61c06c29fc4810d7bf50dfeddeb2bc1ec8f7ab8f
 UnsealKey2        : c97f114cabe98ea2d2ff793fb95a9094f47f85b2919b06e12fbf23c59acdf9ff64
 UnsealKey3        : b71058266ed25bed16494cf4a4e0730a949d5237512fe481b8d1f2919fe179b8f3
 UnsealKey4        : 3a1f5cec04b270bb1784bfc88052449264596ba4e94ca6622094393618427b8a69
 UnsealKey5        : 464880e4bd40b7733646a2c723db3ddbefec8eb9d34d7d6e67e5b3772008d2c98e
 UnsealKey1 base64 : X6vnYqYZ5wBV0uhhemHAbCn8SBDXv1Df7d6yvB7I96uP
 UnsealKey2 base64 : yX8RTKvpjqLS/3k/uVqQlPR/hbKRmwbhL78jxZrN+f9k
 UnsealKey3 base64 : txBYJm7SW+0WSUz0pOBzCpSdUjdRL+SBuNHykZ/hebjz
 UnsealKey4 base64 : Oh9c7ASycLsXhL/IgFJEkmRZa6TpTKZiIJQ5NhhCe4pp
 UnsealKey5 base64 : RkiA5L1At3M2RqLHI9s92+/sjrnTTX1uZ+WzdyAI0smO
 InitialRootToken  : s.hm5HKoytX5mavIHp4lqpIQAX
 #>

 get-vaultstatus -apiaddress $APIaddress

 #start-VaultautoUnseal -apiaddress $apiaddress -VaultPath $vaultpath -UnsealKeyXML "$VaultPath\config\UnsealKeys.xml" -AESKeyFileHash "$VaultPath\config\AESKey.txt"

 

 #$keys = Import-Clixml -path "c:\program files\hashicorp\config\Unsealkeys.xml"

 set-VaultUnseal -apiaddress $APIaddress -unsealkey "5fabe762a619e70055d2e8617a61c06c29fc4810d7bf50dfeddeb2bc1ec8f7ab8f"

 set-VaultUnseal -apiaddress $APIaddress -unsealkey "c97f114cabe98ea2d2ff793fb95a9094f47f85b2919b06e12fbf23c59acdf9ff64"

 set-VaultUnseal -apiaddress $APIaddress -unsealkey "b71058266ed25bed16494cf4a4e0730a949d5237512fe481b8d1f2919fe179b8f3"


 
 
 $LdapDomain = "dtek.com"
 set-VaultLDAP -upndomain $LdapDomain   
  
    