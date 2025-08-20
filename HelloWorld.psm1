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

# Only export the actual PowerShell functions
Export-ModuleMember -Function Write-Hello, Get-HelloInfo, Show-HelloHelp