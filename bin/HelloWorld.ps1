#!/usr/bin/env pwsh
param(
    [Parameter(ValueFromRemainingArguments)]
    [string[]]$RemainingArgs
)

# Import the module
$devModulePath = "$PSScriptRoot\..\HelloWorld.psd1"
if (Test-Path $devModulePath) {
    # Development environment - use local module
    Import-Module $devModulePath -Force
    Write-Verbose "Loaded module from dev location: $devModulePath" -Verbose:$false
} else {
    # Production environment - use system module
    Import-Module HelloWorld -Force
    Write-Verbose "Loaded module from system location" -Verbose:$false
}
# Handle CLI-style commands
if (-not $RemainingArgs -or $RemainingArgs[0] -in @('help','-h','--help','/?')) {
    if ($RemainingArgs.Count -gt 1) {
        Show-HelloHelp -Command $RemainingArgs[1]
    } else {
        Show-HelloHelp
    }
    exit 0
}

switch ($RemainingArgs[0]) {
    'Hello' {
        if ($RemainingArgs.Count -gt 1) {
            Write-Hello -Name $RemainingArgs[1]
        } else {
            Write-Hello
        }
    }
    'Info' { Get-HelloInfo }
    'Help' { 
        if ($RemainingArgs.Count -gt 1) {
            Show-HelloHelp -Command $RemainingArgs[1]
        } else {
            Show-HelloHelp
        }
    }
    'Uninstall' {
        Uninstall-HelloWorld
    }
    default {
        Write-Warning "Unknown command: $($RemainingArgs[0])"
        Show-HelloHelp
    }
}