$box = Get-ItemProperty -Path HKLM:SYSTEM\CurrentControlSet\Control\ComputerName\ComputerName -Name "ComputerName"
$box = $box.ComputerName.ToString().ToLower()

if ($env:COMPUTERNAME -imatch 'vagrant') {

  Write-Host 'Hostname is still the original one, skip provisioning for reboot'

  Write-Host 'Install bginfo'
  . c:\vagrant\scripts\install-bginfo.ps1

  Write-Host -fore red 'Hint: vagrant reload' $box '--provision'

} elseif ((gwmi win32_computersystem).partofdomain -eq $false) {

  Write-Host -fore red "Ooops, workgroup!"

  if (!(Test-Path 'c:\tools\bginfo.exe')) {
    Write-Host 'Install bginfo'
    . c:\vagrant\scripts\install-bginfo.ps1
  }

  if ($env:COMPUTERNAME -imatch 'dc1') {
    . c:\vagrant\scripts\open-firewall.ps1
    . c:\vagrant\scripts\create-domain.ps1
	
  } else {
	Write-Host "Add script that joins to domain."
    . c:\vagrant\scripts\join-domain.ps1
  }

  Write-Host -fore red 'Hint: vagrant reload' $box '--provision'

} else {

  Write-Host -fore green "I am domain joined!"

  if ((Test-Path 'c:\tools\bginfo.exe')) {
    Write-Host 'Install bginfo'
    . c:\vagrant\scripts\install-bginfo.ps1
  }

  Write-Host 'Provisioning after joining domain'

  $script = "c:\vagrant\scripts\provision-" + $box + ".ps1"
  . $script
}