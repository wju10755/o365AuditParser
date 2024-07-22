# PowerShell script to check specified paths for a Python installation

# Get the current user's profile path
$userPath = [Environment]::GetFolderPath("UserProfile")

# Define the paths to check for a Python installation
$pythonPaths = @("C:\Program Files\Python312", "C:\Python312", "C:\Users\JimmyPrice\AppData\Local\Programs\Python\Python312")

# Function to check each path for Python installation
function Check-PythonPath {
    param (
        [string[]]$paths
    )

    foreach ($path in $paths) {
        if (Test-Path $path) {
            Write-Output "Python installation found at: $path"
            return $true
        }
    }

    Write-Output "Python installation not found in the specified paths."
    return $false
}

# Execute the function with the defined paths
$pythonFound = Check-PythonPath -paths $pythonPaths

if (-not $pythonFound) {
    # Python not found at either location
    Write-Output "Downloading Python 3.12, Please Wait..."
    # Define the URL for the Python installer
    $pythonInstallerUrl = "https://www.python.org/ftp/python/3.12.3/python-3.12.3-amd64.exe"
    $installerPath = "$env:TEMP\python_installer.exe"
    # Time the download
    $downloadTime = Measure-Command {
        # Download Python installer 
        Invoke-WebRequest -Uri $pythonInstallerUrl -OutFile $installerPath
    }
    Write-Output "Download done. Time taken: $($downloadTime.TotalSeconds) seconds."
    # Install Python silently with pre-defined options
    Write-Output "Installing Python 3.12, Please Wait..."
    $installTime = Measure-Command {
        Start-Process $installerPath -ArgumentList "/quiet InstallAllUsers=1 PrependPath=1" -NoNewWindow -Wait
    }
    Write-Output "Installation done. Time taken: $($installTime.TotalSeconds) seconds."
    # Remove the installer file after installation
    Remove-Item $installerPath -Force

    # Add Python to the system PATH environment variable
    $pythonInstallPath = "$userPath\AppData\Local\Programs\Python\Python312"
    $envPath = [System.Environment]::GetEnvironmentVariable("Path", [System.EnvironmentVariableTarget]::Machine)
    if (-not $envPath.Split(';').Contains($pythonInstallPath)) {
        $newPath = $envPath + ";$pythonInstallPath"
        [System.Environment]::SetEnvironmentVariable("Path", $newPath, [System.EnvironmentVariableTarget]::Machine)
        Write-Output "Python path added to system PATH environment variable."
    }
}