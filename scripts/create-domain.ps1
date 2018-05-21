Write-Host "Installing Domain services" -ForegroundColor Cyan
  # Disable password complexity policy
  secedit /export /cfg C:\secpol.cfg
  (gc C:\secpol.cfg).replace("PasswordComplexity = 1", "PasswordComplexity = 0") | Out-File C:\secpol.cfg
  secedit /configure /db C:\Windows\security\local.sdb /cfg C:\secpol.cfg /areas SECURITYPOLICY
  rm -force C:\secpol.cfg -confirm:$false

  # Set administrator password
  $computerName = $env:COMPUTERNAME
  $adminPassword = "vagrant"
  $adminUser = [ADSI] "WinNT://$computerName/Administrator,User"
  $adminUser.SetPassword($adminPassword)

  $PlainPassword = "vagrant" # "P@ssw0rd"
  $SecurePassword = $PlainPassword | ConvertTo-SecureString -AsPlainText -Force

 install-windowsfeature AD-Domain-Services
 Install-ADDSForest -CreateDNSDelegation:$false -DatabasePath "C:\Windows\NTDS" -DomainMode "Win2012" -DomainName "corp.contoso.com" -DomainNetBIOSName "CORP" -ForestMode "Win2012" -InstallDNS:$true -LogPath "C:\Windows\NTDS" -NoRebootOnCompletion:$false -SYSVOLPath "C:\Windows\SYSVOL" -Force:$true -safemodeadministratorpassword (convertto-securestring "Password1" -asplaintext -force)
 Write-host "Ending installation at:" (get-date) -ForegroundColor Cyan
 #post installation 
 #New-ADUser jarek -AccountPassword (ConvertTo-SecureString "Password1" -AsPlainText -Force)
 #Add-ADGroupMember "domain users" -Members jarek
 #Enable-ADAccount jarek