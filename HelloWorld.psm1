$script:CommandMap = @{
    "Help"  = { param($Command) if ($Command) { Show-HelloHelp -Command $Command } else { Show-HelloHelp } }
    "Hello" = { param($Name) Write-Hello @PSBoundParameters }
    "Info"  = { Get-HelloInfo }
}

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
        ($script:CommandMap.Keys | Sort-Object) | ForEach-Object { "  $_" }
        "`nUsage:`n  HelloWorld Help <Command>`n  HelloWorld <Command> [options]"
        return
    }

    # Try to map friendly names to function help
    $nameToFunc = @{
        'Hello' = 'Write-Hello'
        'Info'  = 'Get-HelloInfo'
        'Help'  = 'Show-HelloHelp'
    }

    if ($nameToFunc.ContainsKey($Command)) {
        Get-Help $nameToFunc[$Command] -Full
    } else {
        Write-Warning "Unknown command: $Command"
        Show-HelloHelp
    }
}

function HelloWorld {
    [CmdletBinding(PositionalBinding=$false)]
    param(
        [Parameter(ValueFromRemainingArguments)]
        [string[]]$RemainingArgs
    )

    if (-not $RemainingArgs -or $RemainingArgs[0] -in @('help','-h','--help','/?')) {
        $sub = if ($RemainingArgs.Count -gt 1) { $RemainingArgs[1] } else { $null }
        return Show-HelloHelp -Command $sub
    }

    $cmd  = $RemainingArgs[0]
    $rest = if ($RemainingArgs.Count -gt 1) { $RemainingArgs[1..($RemainingArgs.Count-1)] } else { @() }

    if ($script:CommandMap.ContainsKey($cmd)) {
        & $script:CommandMap[$cmd] @rest
    }
    else {
        Write-Warning "Unknown command: $cmd. Use 'HelloWorld Help' for available commands."
    }
}

# Only export the intended public functions
Export-ModuleMember -Function HelloWorld, Write-Hello, Get-HelloInfo, Show-HelloHelp