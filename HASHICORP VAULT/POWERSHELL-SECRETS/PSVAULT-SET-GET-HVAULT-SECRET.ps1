#https://github.com/D2CIT/Hashicorp-Vault

#   KEY         s.hm5HKoytX5mavIHp4lqpIQAX
#   API         http://HashiVault.dtek.com:8200
#   ENGINES     dtek-SCO-KV
#   Secret      SCORunbook/SVC-RBacc01


$Env:Path += ";C:\Program Files\hashicorp"
$ENV:path
$APIaddress = "http://HashiVault.dtek.com:8200"
$SecretEngineName = "dtek-SCO-KV" 
$secretPath       = "SCORunbook/SVC-RBacc04"

import-module PSVAULT

Get-Command -module PSVAULT

get-help -name set-VaultLDAP

#Connect-Vault [[-VaultPath] <String>] [[-APIAddress] <Object>] [-token] <Object> [-quite] [<CommonParameters>]

$vaultConnect=Connect-Vault -VaultPath  "dtek-SCO-KV" -APIAddress "http://10.10.10.75:8200" -token "s.hm5HKoytX5mavIHp4lqpIQAX"
#ok

$vaultstatus =  get-vaultstatus -apiaddress $APIaddress
$vaultstatus

#get-Vaultobject [-Address] <String> [-Token] <String> [<CommonParameters>]

$vaultobject= get-Vaultobject -Address "http://10.10.10.75:8200" -token "s.hm5HKoytX5mavIHp4lqpIQAX"
$vaultobject
#ok

#set-VaultSecret [[-VaultObject] <Object>] [[-secretEnginename] <Object>] [[-SecretPath] <Object>] [[-KvVersion] <Object>] [[-username] <Object>] [[-password] <Object>]  [[-environment] <Object>] [[-tag] <Object>] [[-server] <Object>] [<CommonParameters>]
set-VaultSecret -VaultObject $vaultobject -secretEnginename "dtek-SCO-KV" -SecretPath "SCORunbook/SVC-RBacc05" -username "SVC-RBacc05" -password "Popeye@49" -environment "Dtek-Prod" -tag "SCOAccess"

#Invoke-RestMethod: No connection could be made because the target machine actively refused it.

 
$SecretEngineName = "dtek-SCO-KV" 
$secretPath="SCORunbook/SVC-RBacc02"
 
#get-VaultSecret [[-VaultObject] <Object>] [[-secretEnginename] <Object>] [[-SecretPath] <Object>] [[-kvversion] <Object>] [<CommonParameters>]
$cred = get-VaultSecret -VaultObject $vaultobject -secretEnginename $SecretEngineName -SecretPath $secretPath -kvversion '2' 
$cred.password 

<<<<<<< HEAD
#all tested ok with ROOT Token 


# with limited TOKEN created against a policy
  
& vault token create -policy="scorunbook-access-readonly"
#ok
# TOKEN=    s.DHZoOYfDyqk4GAxLo1aUQ3oT 
 
 
#attach to Vault 
$vaultobject = Get-Vaultobject -Address "http://10.10.10.75:8200" -Token "s.DHZoOYfDyqk4GAxLo1aUQ3oT" 
$vaultobject

#get secret
$secretPath="SCORunbook/SVC-RBacc02"
$SecretEngineName = "dtek-SCO-KV"  
$cred = get-VaultSecret -VaultObject $vaultobject -secretEnginename $SecretEngineName -SecretPath $secretPath 
$cred.password  
#ok

#will not allow secret access to another secret engine with token used above 
$SecretEngineName = "dtek-Azure-KV" 
$secretPath       = "AZURE/SVC-AZacc01"
$cred = get-VaultSecret -VaultObject $vaultobject -secretEnginename $SecretEngineName -SecretPath $secretPath 
$cred.password  
#ok

# Use token in enviroment variable

$Env:VAULT_ADDR='http://10.10.10.75:8200'

$Env:VAULT_TOKEN="s.hm5HKoytX5mavIHp4lqpIQAX"

#get code to use this in get-vaultobject
=======
#set-VaultLDAP [[-upndomain] <String>] [[-LDAPUrl] <String>] [[-userattr] <String>] [[-userdn] <String>] [[-groupdn] <String>] [[-groupattr] <String>] [[-insecure_tls]      <Boolean>] [<CommonParameters>]

set-VaultLDAP  -upndomain "dtek.com" `
-LDAPUrl  "ldap://dtekad05.dtek.com:389" `
-userattr "sAMAccountName" `
-userdn "dc=dtek,dc=com" `
-groupdn "dc=dtek,dc=com" `
-groupattr "cn" `
-insecure_tls $false
>>>>>>> f416783bc4d4ceec053770e6bd1c6de7aea009c5
