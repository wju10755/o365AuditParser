Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.SendKeys]::SendWait('~');
if ((Get-Packageprovider -Name NuGet) -eq $null) {
    #Write-Output 'NuGet package provider not found!'
    #Write-Output 'Installing NuGet 2.8.5.201 Provider, Please Wait..'
    try {
        Install-Packageprovider -name nuget -requiredVersion 2.8.5.201 -force -ErrorAction Stop | Out-Null
        #Write-Output 'NuGet package provider installed successfully.'
    } catch {
        #Write-Output "Failed to install NuGet package provider: $_"
    }
} else {
    #Write-Output 'NuGet package provider is installed!'
}
# Accept package provider installation
[System.Windows.Forms.SendKeys]::SendWait('~');
#Write-Host 'Validating Availability of PSWindows Update Module, Please Wait...' 
if ((Get-Module -Name PSWindowsUpdate) -eq $null) {
    #Write-Host -ForegroundColor Yellow 'PSWindowsUpdate module not found!'
    #Write-Host 'Installing PSWindowsUpdate Module, Please Wait...'
    Install-Module -name PSWindowsUpdate -force -ErrorAction SilentlyContinue -WarningAction SilentlyContinue | Out-Null
    }
