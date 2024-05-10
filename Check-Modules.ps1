# NuGet Provider Check
if (-Not (Get-PackageProvider -Name NuGet -ErrorAction SilentlyContinue)) {
    Write-Output "NuGet is not installed. Installing NuGet..."
    Install-PackageProvider -Name NuGet -Force -Confirm:$false -ForceBootstrap
    Import-PackageProvider -Name NuGet
} else {
    Write-Output "NuGet is already installed."
}
