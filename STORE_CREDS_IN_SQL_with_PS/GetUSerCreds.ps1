function Get-ErrorInformation {
    [cmdletbinding()]
    param($incomingError)

    if ($incomingError -and (($incomingError| Get-Member | Select-Object -ExpandProperty TypeName -Unique) -eq 'System.Management.Automation.ErrorRecord')) {

        Write-Host `n"Error information:"`n
        Write-Host `t"Exception type for catch: [$($IncomingError.Exception | Get-Member | Select-Object -ExpandProperty TypeName -Unique)]"`n 

        if ($incomingError.InvocationInfo.Line) {
        
            Write-Host `t"Command                 : [$($incomingError.InvocationInfo.Line.Trim())]"
        
        } else {

            Write-Host `t"Unable to get command information! Multiple catch blocks can do this :("`n

        }

        Write-Host `t"Exception               : [$($incomingError.Exception.Message)]"`n
        Write-Host `t"Target Object           : [$($incomingError.TargetObject)]"`n
    
    }

    Else {

        Write-Host "Please include a valid error record when using this function!" -ForegroundColor Red -BackgroundColor DarkBlue

    }

}


#assume sqlserver PS module is installed

#[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
#install-module -Name sqlserver
import-module sqlserver;
 
$db = 'DTEK_IDENTITY_MANAGEMENT'; # the db hosting dbo.[UserEncryptedPwd]
$svr = 'dteksq2017-n1.dtek.com' # the sql instance hosting database $db
$username = 'dhobbs-adm'; #replace per your requirement

$ErrorActionPreference = "STOP"
$qry = @"
select EncryptedPwd from dbo.UserEncryptedPwd
where UserName='$($username)'
--and Creator = '$($env:USERNAME)'
--and HostComputer = '$($env:COMPUTERNAME)'
"@;
 
$rslt = invoke-sqlcmd -ServerInstance $svr -Database $db -Query $qry -OutputAs DataRows;
$secure_str = $rslt.EncryptedPwd;
 
#decrypt 

try {
$orig_pwd=[Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]:: SecureStringToBSTR($($secure_str| Convertto-SecureString))); 
} 
catch
{
    Get-ErrorInformation -incomingError $_
    exit
}


 
#for verification
write-host "The original password for user [$username] is: [$orig_pwd]"

