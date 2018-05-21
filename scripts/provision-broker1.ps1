write-host "Additional command goes here"
tzutil /s "Central European Standard Time"
Import-Module RemoteDesktop
New-SessionDeployment -ConnectionBroker broker1.corp.contoso.com -WebAccessServer gw1.corp.contoso.com -SessionHost sessionhost1.corp.contoso.com
New-RDSessionCollection -CollectionName MySessionCollection -SessionHost sessionhost1.corp.contoso.com -CollectionDescription "Collection for Paint and Calc" -ConnectionBroker broker1.corp.contoso.com
new-rdremoteapp -Alias Wordpad -DisplayName WordPad -FilePath "C:\Program Files\Windows NT\Accessories\wordpad.exe" -ShowInWebAccess 1 -collectionname MySessionCollection -ConnectionBroker broker1.corp.contoso.com
Set-RDRemoteApp -CollectionName MySessionCollection -Alias Wordpad -UserGroups "domain users" -ConnectionBroker broker1.corp.contoso.com