if (!(Test-Path 'c:\tools')) {
  New-Item -Path 'c:\Program Files\sysinternals' -type directory -Force -ErrorAction SilentlyContinue
}
if (!(Test-Path 'c:\tools\bginfo.exe')) {
  (New-Object Net.WebClient).DownloadFile('http://live.sysinternals.com/bginfo.exe', 'c:\tools\bginfo.exe')
}
$vbsScript = @'
WScript.Sleep 15000
Dim objShell
Set objShell = WScript.CreateObject( "WScript.Shell" )
objShell.Run("""c:\tools\bginfo.exe"" /accepteula ""c:\tools\bginfo.bgi"" /silent /timer:0")
'@

$vbsScript | Out-File 'c:\tools\bginfo.vbs'

Copy-Item "C:\vagrant\scripts\bginfo.bgi" 'c:\tools\bginfo.bgi'

Set-ItemProperty HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run -Name bginfo -Value 'wscript "c:\tools\bginfo.vbs"'