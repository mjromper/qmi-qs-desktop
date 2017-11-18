Write-Host "Disabling Firewall"
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False  | Out-Null

$url='https://da3hntz84uekx.cloudfront.net/QlikSenseDesktop/11.14/1/_MSI/Qlik_Sense_Desktop_setup.exe'
$dlLoc='C:\Users\vagrant\Downloads\Qlik_Sense_Desktop_setup.exe'
Write-Host "Downloading Qlik Sense Desktop binaries"
(New-Object System.Net.WebClient).DownloadFile($url, $dlLoc)

Write-Host "Installing Qlik Sense Desktop..."
Unblock-File -Path C:\Users\vagrant\Downloads\Qlik_Sense_Desktop_setup.exe
Invoke-Command -ScriptBlock {Start-Process -FilePath "C:\Users\vagrant\Downloads\Qlik_Sense_Desktop_setup.exe" -ArgumentList "-s"}

while (!(Test-Path "C:\Users\vagrant\AppData\Local\Programs\Qlik\Sense\QlikSense.exe")) {
    Write-Host "Wait, Qlik Sense Desktop is being installed... next check in 60 secs"
    Start-Sleep -s 60
}

Write-Host "Qlik Sense Desktop install finished."