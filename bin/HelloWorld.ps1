#!/usr/bin/env pwsh
param(
    [Parameter(ValueFromRemainingArguments)]
    [string[]]$RemainingArgs
)

# Import the module
Import-Module "$PSScriptRoot\..\HelloWorld.psd1" -Force

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
    default {
        Write-Warning "Unknown command: $($RemainingArgs[0])"
        Show-HelloHelp
    }
}