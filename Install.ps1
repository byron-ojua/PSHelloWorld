<#
.SYNOPSIS
    Installs the HelloWorld module system-wide
.DESCRIPTION
    Installs module for all users and adds CLI wrapper to PATH
.PARAMETER Dev
    If specified, creates symlinks for development instead of copying files
.EXAMPLE
    .\Install.ps1
#>
#Requires -RunAsAdministrator

$ModuleName = "HelloWorld"
$SourcePath = $PSScriptRoot

# Install locations
$moduleLocations = @(
    "$env:ProgramFiles\WindowsPowerShell\Modules\$ModuleName"
    "$env:ProgramFiles\PowerShell\Modules\$ModuleName"  
)
$programPath = "$env:ProgramFiles\$ModuleName"
Write-Host "Installing $ModuleName module..." -ForegroundColor Cyan
foreach ($modulePath in $moduleLocations) {
    New-Item -Path $modulePath -ItemType Directory -Force | Out-Null
    Copy-Item -Path "$SourcePath\$ModuleName.ps*" -Destination $modulePath -Force
}

# Copy binaries and uninstall script
Write-Host "Installing CLI wrapper..." -ForegroundColor Cyan
New-Item -Path $programPath -ItemType Directory -Force | Out-Null
Copy-Item -Path "$SourcePath\bin\*" -Destination $programPath -Recurse -Force
Copy-Item -Path "$SourcePath\Uninstall.ps1" -Destination $programPath -Force

# Add to system and current PATH
Write-Host "Adding $programPath to system PATH and current context..."
$currentPath = [Environment]::GetEnvironmentVariable("Path", "Machine")
if ($currentPath -notlike "*$programPath*") {
    [Environment]::SetEnvironmentVariable("Path", "$currentPath;$programPath", "Machine")
}
if ($env:Path -notlike "*$programPath*") {
    $env:Path += ";$programPath"
}

Write-Host "Installation complete!" -ForegroundColor Green
