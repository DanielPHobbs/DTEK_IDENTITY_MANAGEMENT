#https://github.com/D2CIT/Hashicorp-Vault

#   KEY         s.u5eAjYu9tdRDkmrZe0L3TwBu
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

get-help -name get-VaultSecret

#Connect-Vault [[-VaultPath] <String>] [[-APIAddress] <Object>] [-token] <Object> [-quite] [<CommonParameters>]

$vaultConnect=Connect-Vault -VaultPath  "dtek-SCO-KV" -APIAddress "http://HashiVault.dtek.com:8200" -token "s.u5eAjYu9tdRDkmrZe0L3TwBu"
#ok

$vaultstatus =  get-vaultstatus -apiaddress $APIaddress
$vaultstatus

#get-Vaultobject [-Address] <String> [-Token] <String> [<CommonParameters>]

$vaultobject= get-Vaultobject -Address "http://HashiVault.dtek.com:8200" -token "s.Z8KCd2sFSDJN1FtBREGy4g8t"
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