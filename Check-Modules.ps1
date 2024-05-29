# NuGet Provider Check
if (-Not (Get-PackageProvider -Name NuGet -ErrorAction SilentlyContinue)) {
    Write-Output "NuGet is not installed. Installing NuGet..."
    Install-PackageProvider -Name NuGet -Force -Confirm:$false -ForceBootstrap
    Import-PackageProvider -Name NuGet
} else {
    Write-Output "NuGet is already installed."
}

# AzureAD Module Check
If (Get-Module -ListAvailable -name AzureAD) {
    Write-Output "AzureAD PowerShell Module Detected"
    Import-Module AzureAD
} else {
    Write-Host -ForegroundColor Red "AzureAD Module not found!"
    Write-Output "Installing AzureAD Module, please wait..."
    Install-Module -Name AzureAD -Scope CurrentUser -AllowClobber -Force
}
 