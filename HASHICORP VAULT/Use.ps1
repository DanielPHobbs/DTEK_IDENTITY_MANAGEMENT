#Load VauLtobject
$vaultobject = Get-Vaultobject -Address "http://10.10.10.75:8200" -Token "s.hm5HKoytX5mavIHp4lqpIQAX"  
$vaultobject

$APIaddress = "http://10.10.10.75:8200"

$vaultstatus =  get-vaultstatus -apiaddress $APIaddress
$vaultstatus

$SecretEngineName = "dtek-Azure-KV" 
new-VaultSecretEngine -vaultobject $vaultobject -SecretEngineName $SecretEngineName 



$SecretEngineName = "dtek-Azure-KV" 
$secretPath       = "AZURE/SVC-AZacc01"
set-VaultSecret -VaultObject $vaultobject -secretEnginename $SecretEngineName -SecretPath $secretPath  -username  "SVC-AZacc01" -password "Popeye@45" -environment "Dtek-Prod" -tag "Azure"







$SecretEngineName = "dtek-SCO-KV" 
$secretPath       = "SCORunbook/SVC-RBacc01"
set-VaultSecret -VaultObject $vaultobject -secretEnginename $SecretEngineName -SecretPath $secretPath  -username  "SVC-RBacc01" -password "Popeye@45" -environment "Dtek-Prod" -tag "SCOAccess"
$secretPath       = "SCORunbook/SVC-RBacc02"
set-VaultSecret -VaultObject $vaultobject -secretEnginename $SecretEngineName -SecretPath $secretPath  -username  "SVC-RBacc02" -password "Popeye@46" -environment "Dtek-Prod" -tag "SCOAccess"


$secretPath       = "SCORunbook/SVC-RBacc04"
set-VaultSecret -VaultObject $vaultobject -secretEnginename $SecretEngineName -SecretPath $secretPath  -username  "SVC-RBacc04" -password "Popeye@48" -environment "Dtek-Prod" -tag "SCOAccess"

 
 $secretPath="SCORunbook/SVC-RBacc02"
 
 $cred = get-VaultSecret -VaultObject $vaultobject -secretEnginename $SecretEngineName -SecretPath $secretPath 
 $cred.password 



# with limited TOKEN
  
& vault token create -policy="scorunbook-access-readonly"
#ok
#     s.DHZoOYfDyqk4GAxLo1aUQ3oT 
 
 
$vaultobject = Get-Vaultobject -Address "http://10.10.10.75:8200" -Token "s.DHZoOYfDyqk4GAxLo1aUQ3oT" 
$vaultobject

$secretPath="SCORunbook/SVC-RBacc02"
$SecretEngineName = "dtek-SCO-KV"  
$cred = get-VaultSecret -VaultObject $vaultobject -secretEnginename $SecretEngineName -SecretPath $secretPath 
$cred.password  
#ok


$SecretEngineName = "dtek-Azure-KV" 
$secretPath       = "AZURE/SVC-AZacc01"
$cred = get-VaultSecret -VaultObject $vaultobject -secretEnginename $SecretEngineName -SecretPath $secretPath 
$cred.password  
#will not allow secret access with token used above 