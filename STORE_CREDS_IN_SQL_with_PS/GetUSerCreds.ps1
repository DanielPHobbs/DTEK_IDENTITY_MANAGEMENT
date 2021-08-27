#assume sqlserver PS module is installed
import-module sqlserver;
 
$db = 'DTEK_IDENTITY_MANAGEMENT'; # the db hosting dbo.[UserEncryptedPwd]
$svr = 'dteksq2017-n1.dtek.com' # the sql instance hosting database $db
$username = 'Stanley.laurel'; #replace per your requirement
$qry = @"
select EncryptedPwd from dbo.UserEncryptedPwd
where UserName='$($username)'
and Creator = '$($env:USERNAME)'
and HostComputer = '$($env:COMPUTERNAME)'
"@;
 
$rslt = invoke-sqlcmd -ServerInstance $svr -Database $db -Query $qry -OutputAs DataRows;
$secure_str = $rslt.EncryptedPwd;
 
#decrypt the original text, i.e. "hello world"
$orig_pwd=[Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::
SecureStringToBSTR($($secure_str| Convertto-SecureString))); 
 
#for verification
write-host "The original password for user [$username] is: [$orig_pwd]";