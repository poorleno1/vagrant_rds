Write-host "Creating jarek account with pass Password1"
Import-Module ActiveDirectory
New-ADUser jarek -AccountPassword (ConvertTo-SecureString "Password1" -AsPlainText -Force)
Add-ADGroupMember "domain admins" -Members jarek
Enable-ADAccount jarek