function Write-Hello {
<#
.SYNOPSIS
    Prints a hello message.

.DESCRIPTION
    Demonstrates a simple PowerShell module function that takes a name
    and outputs a friendly greeting.

.PARAMETER Name
    Name of the person to greet. Defaults to "World".

.EXAMPLE
    Write-Hello
    Hello, World!

.EXAMPLE
    Write-Hello -Name "John"
    Hello, John!
#>
    [CmdletBinding()]
    param(
        [Parameter(Position=0)]
        [Alias('n')]
        [string]$Name = "World"
    )
    "Hello, $Name!"
}

function Get-HelloInfo {
<#
.SYNOPSIS
    Displays information about this module.

.DESCRIPTION
    Returns metadata about the Hello World module.

.EXAMPLE
    Get-HelloInfo
#>
    [CmdletBinding()]
    param()

    [PSCustomObject]@{
        Module   = 'HelloWorld'
        Author   = 'Byron Ojua-Nice'
        Version  = '1.0.0'
        Purpose  = 'Demonstrate a simple PowerShell module'
    }
}

function Show-HelloHelp {
    [CmdletBinding()]
    param([string]$Command)

    if (-not $Command) {
        Write-Host "Available commands:" -ForegroundColor Cyan
        Write-Host "  Hello  - Write a greeting message"
        Write-Host "  Info   - Get module information"
        Write-Host "  Help   - Show this help"
        return
    }

    # Map friendly names to function help
    switch ($Command) {
        'Hello' { Get-Help Write-Hello -Full | Out-String | Write-Host }
        'Info'  { Get-Help Get-HelloInfo -Full | Out-String | Write-Host }
        'Help'  { Get-Help Show-HelloHelp -Full | Out-String | Write-Host }
        default {
            Write-Warning "Unknown command: $Command"
            Show-HelloHelp
        }
    }
}

function Uninstall-HelloWorld {
<#
.SYNOPSIS
    Uninstalls the HelloWorld module from the system
.DESCRIPTION
    Removes HelloWorld module from all PowerShell module directories and removes CLI wrapper from PATH
.PARAMETER Force
    Skip confirmation prompt
.EXAMPLE
    Uninstall-HelloWorld
.EXAMPLE
    Uninstall-HelloWorld -Force
#>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='High')]
    param(
        [switch]$Force
    )
    
    # Check for admin rights
    $isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")
    if (-not $isAdmin) {
        Write-Error "Administrator privileges required to uninstall. Please run as Administrator."
        return
    }
    
    $ModuleName = "HelloWorld"
    
    # Confirm with user unless -Force
    if (-not $Force) {
        $response = Read-Host "Are you sure you want to uninstall $ModuleName? (Y/N)"
        if ($response -ne 'Y') {
            Write-Host "Uninstall cancelled." -ForegroundColor Yellow
            return
        }
    }
    
    Write-Host "Uninstalling $ModuleName..." -ForegroundColor Yellow
    
    # Remove from all locations
    $locations = @(
        "$env:ProgramFiles\WindowsPowerShell\Modules\$ModuleName"
        "$env:ProgramFiles\PowerShell\Modules\$ModuleName"
        "$env:ProgramFiles\$ModuleName"
    )
    
    foreach ($path in $locations) {
        if (Test-Path $path) {
            Remove-Item $path -Recurse -Force
            Write-Host "Removed: $path" -ForegroundColor Yellow
        }
    }
    
    # Remove from PATH
    $currentPath = [Environment]::GetEnvironmentVariable("Path", "Machine")
    $newPath = ($currentPath -split ';' | Where-Object { $_ -notlike "*\$ModuleName" }) -join ';'
    if ($currentPath -ne $newPath) {
        [Environment]::SetEnvironmentVariable("Path", $newPath, "Machine")
        Write-Host "Removed from system PATH" -ForegroundColor Yellow
    }
    
    Write-Host "Uninstall complete! Restart PowerShell for changes to take effect." -ForegroundColor Green
    Write-Host "Note: This window's session still has the module loaded." -ForegroundColor Cyan
}

# Add to your Export-ModuleMember line:
Export-ModuleMember -Function Write-Hello, Get-HelloInfo, Show-HelloHelp, Uninstall-HelloWorld