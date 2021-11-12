Install-Module -Name Microsoft.PowerShell.SecretManagement -Repository PSGallery

Install-Module -Name Microsoft.PowerShell.SecretStore -Repository PSGallery


Install-Module -Name SecretManagement.Hashicorp.Vault.KV



Get-Command -Module Microsoft.PowerShell.SecretManagement


Get-SecretVault

#Register-SecretVault -Name MySecrets -ModuleName Microsoft.PowerShell.SecretStore -DefaultVault

#Set-Secret -Name Password -Secret "Pass@word1"

Get-Secret -Name Password

Get-Secret -Name Password -AsPlainText

Set-Secret -Name OAuthToken -Secret "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9" -Metadata @{Purpose="Office 365 OAuth Token"}

Get-SecretInfo -Name OAuthToken

# Create Microsoft 365 Credential Secret
$username = "admin@domain.onmicrosoft.com"
$password = ConvertTo-SecureString "Pass@word1" -AsPlainText -Force
$creds = New-Object System.Management.Automation.PSCredential($username,$password)
# Create the secret by storing the PSCredential object
Set-Secret -Name M365 -Secret $cred -Metadata @{Information="M365 Credentials for Tenant"}
# Retrieve the Stored Credentials
$m365creds = Get-Secret -Name M365Creds
# Connect to Microsoft Online with the retrieved credentials
Connect-MsolService -Credential $m365creds

Enter-PSSession -ComputerName mun-dc01 -Credential (Get-Secret -Vault MyDomainPassdb -Name adm_maxbak)

$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri http://mun-exch1.woshub.com/PowerShell/ -Authentication Kerberos -Credential (Get-Secret -Vault MyDomainPassdb -Name adm_ex_maxbak)

$Cred = Get-Secret -Vault MyDomainPassdb user1



Install-Module -Name Microsoft.PowerShell.SecretStore -Repository PSGallery -Force
$password = Import-CliXml -Path $securePasswordPath

Set-SecretStoreConfiguration -Scope CurrentUser -Authentication Password -PasswordTimeout 3600 -Interaction None -Password $password -Confirm:$false

Install-Module -Name Microsoft.PowerShell.SecretManagement -Repository PSGallery -Force
Register-SecretVault -Name SecretStore -ModuleName Microsoft.PowerShell.SecretStore -DefaultVault

Unlock-SecretStore -Password $password


## Register Hasicore Keyvault

Install-Module -Name SecretManagement.Hashicorp.Vault.KV


## requires V6
#Register-SecretVault -ModuleName SecretManagement.Hashicorp.Vault.KV -Name dtek-prod-HVault -VaultParameters @{ VaultServer = 'http://hashivault.dtek.com:8200'; VaultAuthType = 'Token'}
Register-SecretVault -ModuleName SecretManagement.Hashicorp.Vault.KV -Name dtek-SCO-KV  -VaultParameters @{ VaultServer = 'http://vault.domain.local:8200'; VaultToken = 's.u5eAjYu9tdRDkmrZe0L3TwBu'}
Register-SecretVault -ModuleName SecretManagement.Hashicorp.Vault.KV -Name kv/  -VaultParameters @{ VaultServer = 'http://vault.domain.local:8200'; VaultToken = 's.u5eAjYu9tdRDkmrZe0L3TwBu'}

$vault = Get-SecretVault 
$vaultname= $Vault.Name

#Test-SecretVault $vaultname
Set-Secret -Name "Secret1" -Secret "SecretValue" -Vault "kv/"-Verbose

Get-Secret -Vault $vaultname 


## https://github.com/joshcorr/SecretManagement.Hashicorp.Vault.KV