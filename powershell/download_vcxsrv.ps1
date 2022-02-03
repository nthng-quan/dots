$vcxsrvUrl = "https://vcxsrv.com/wp-content/uploads/2024/09/vcxsrv-64.1.17.2.0.installer.zip"
$tempPath = "$env:TEMP\vcxsrv_installer"
$zipFile = "$tempPath\vcxsrv_installer.zip"

if (!(Test-Path $tempPath)) {
    New-Item -ItemType Directory -Path $tempPath | Out-Null
}

Write-Output "Downloading VcXsrv installer..."
Invoke-WebRequest -Uri $vcxsrvUrl -OutFile $zipFile

Write-Output "Extracting installer..."
Add-Type -AssemblyName System.IO.Compression.FileSystem
[System.IO.Compression.ZipFile]::ExtractToDirectory($zipFile, $tempPath)

$installerExe = Get-ChildItem -Path $tempPath -Filter *.exe | Select-Object -First 1

if ($null -ne $installerExe) {
    Write-Output "Running installer..."
    Start-Process -FilePath $installerExe.FullName -ArgumentList "/silent" -Wait
    Write-Output "Installation completed."
} else {
    Write-Error "Installer .exe not found in the extracted ZIP."
}

Write-Output "Cleaning up..."
Remove-Item -Path $tempPath -Recurse -Force
