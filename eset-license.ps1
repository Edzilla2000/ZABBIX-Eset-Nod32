Param(
	[Parameter(Mandatory=$true)] 
	[string]$command
)
$user = "monitoring"
$password = "strongpassword"
$server = "eras"
$TempFile = $env:temp+"\ErasLicense.csv"


if ($command -eq "expires")
{
	$today = get-date
	$license = & 'C:\Program Files (x86)\ESET\ESET Remote Administrator\Console\eracmd.exe' --s $server --p $password --u $user license details -color false -format csv -out $TempFile -delim ';'

	$csv = import-csv -Delimiter ";" $TempFile
	foreach ($line in $csv)
	{
		$expires = get-date($line.license_expires)
		(NEW-TIMESPAN .Start $today $expires).Days
	}
}
elseif ($command -eq "max_clients")
{
	$license = & 'C:\Program Files (x86)\ESET\ESET Remote Administrator\Console\eracmd.exe' --s $server --p $password --u $user license details -color false -format csv -out $TempFile -delim ';'
	$csv = import-csv -Delimiter ";" $TempFile
	foreach ($line in $csv)
	{
		$line.license_clients
	}
}
elseif ($command -eq "clients")
{
	$license = & 'C:\Program Files (x86)\ESET\ESET Remote Administrator\Console\eracmd.exe' --s $server --p $password --u $user show client count -color false -format csv -out $TempFile -delim ';'
	$csv = import-csv -Delimiter ";" $TempFile
	foreach ($line in $csv)
	{
		$line.count
	}
}
