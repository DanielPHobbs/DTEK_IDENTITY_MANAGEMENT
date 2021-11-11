$Vault_Address       = 'http://127.0.0.1:8200'
$VAULT_ROOT          = $Vault_Address + '/v1'
$VAULT_LOGIN_APPROLE = $VAULT_ROOT+'/auth/approle/login'
$VAULT_KV_PATH       = $VAULT_ROOT+'/kv/user'

$RoleID              = 'fdacdafeasdadfa'
$SecretID            = 'ddafdacadcadadc'

#Set env variable for vault address
$ENV:VAULT_ADDR = $Vault_Address

#Payload
$payload = @{
    "role_id"   = $RoleID
    "secret_id" = $SecretID
  } | ConvertTo-Json

#Get client token from approle login
$Client_Token = Invoke-RestMethod -Method Post -Uri $VAULT_LOGIN_APPROLE -body $payload -Headers @headers

#Set vault token environment variable
$ENV:VAULT_TOKEN = $Client_Token

#Header
$header = @{
   'X-Vault-Token' = ${ENV:VAULT_TOKEN}
}

#Get the password from KV
$KV_Password = Invoke-RestMethod -Method Get -Uri $VAULT_KV_PATH -Headers $header

$KV_Password