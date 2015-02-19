# ZABBIX-Eset-Nod32

Monitoring Nod32 remote admin server license expiration using Zabbix

in zabbix_agentd.conf add this userparameter
UserParameter=eset[*],%SystemRoot%\system32\WindowsPowerShell\v1.0\powershell.exe -nologo -command "& 'C:\Program Files\Zabbix Agent\eset-license.ps1' $1"
