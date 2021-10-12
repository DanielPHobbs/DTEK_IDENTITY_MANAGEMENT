#assume sqlserver PS module is installed
#Install-Module -Name SqlServer -AllowClobber

import-module sqlserver;
 
$db = 'DTEK_IDENTITY_MANAGEMENT';   # the db hosting dbo.[UserEncryptedPwd]
$svr = 'dteksq2017-n1.dtek.com'     # the sql instance hosting database $db
$username = 'dhobbs-adm';       #replace per your requirement
$userPwd ='Popeye@44'              # replace per your requirement
 
$pwd_ss = ConvertTo-SecureString -String $userPwd -AsPlainText -Force|ConvertFrom-SecureString;
 
$t = new-object System.Data.DataTable;
$col = new-object System.Data.DataColumn ('UserName', [system.string]);
$t.Columns.add($col);
$col = new-object System.Data.DataColumn ('EncryptedPwd', [system.string]);
$t.Columns.add($col);
$col = new-object System.Data.DataColumn ('Creator', [system.string]);
$t.Columns.add($col);
$col = new-object System.Data.DataColumn ('HostComputer', [system.string]);
$t.Columns.add($col);
$record = $t.NewRow();
$record.UserName = $username
$record.EncryptedPwd = $pwd_ss;
$record.Creator = $env:UserName;
$record.HostComputer = $env:COMPUTERNAME;
$t.Rows.add($record);
Write-SqlTableData -ServerInstance $svr -DatabaseName $db -SchemaName dbo -TableName 'UserEncryptedPwd' -InputData $t;