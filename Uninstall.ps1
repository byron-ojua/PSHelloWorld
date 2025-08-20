<#
.SYNOPSIS
    Uninstalls the HelloWorld module system-wide
.DESCRIPTION
    Removes module for all users and CLI wrapper from PATH
.EXAMPLE
    .\Uninstall.ps1
#>
#Requires -RunAsAdministrator

try {
    # Import the module so its functions are available
    Import-Module HelloWorld -Force -ErrorAction Stop

    if (Get-Command Uninstall-HelloWorld -ErrorAction SilentlyContinue) {
        Write-Host "Running module uninstall..."
        Uninstall-HelloWorld -Force
        Write-Host "Uninstall complete." -ForegroundColor Green
    }
    else {
        Write-Error "HelloWorld module does not provide an Uninstall-HelloWorld function."
        exit 1
    }
}
catch {
    Write-Error "Failed to load or uninstall HelloWorld: $($_.Exception.Message)"
    exit 1
}