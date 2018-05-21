Write-host "Openinig firewalls" -ForegroundColor Cyan
 netsh advfirewall firewall add rule name="SMB" dir=in action=allow protocol=TCP localport=139
 netsh advfirewall firewall add rule name="SMB" dir=in action=allow protocol=TCP localport=445
 netsh advfirewall firewall add rule name="SMB" dir=in action=allow protocol=TCP localport=135
 netsh advfirewall firewall add rule name="RPC_In" dir=in action=allow protocol=TCP localport=49152-65535
 netsh advfirewall firewall add rule name="DNS_In" dir=in action=allow protocol=TCP localport=53
 netsh advfirewall firewall add rule name="DNS_In" dir=in action=allow protocol=UDP localport=53
 netsh advfirewall firewall add rule name="LDAP" dir=in action=allow protocol=TCP localport=389
 tzutil /s "Central European Standard Time"