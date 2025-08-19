# IiqHelloWorld.psm1
function Write-Hello {
    [CmdletBinding()]
    param(
        [string]$Name = "World"
    )
    Write-Output "Hello, $Name!"
}

function Show-Help {
    Write-Output "Available functions:"
    Write-Output "  Say-Hello -Name <YourName>   # Greets you"
    Write-Output "  Show-Help                    # Shows this message"
}

Export-ModuleMember -Function Write-Hello, Show-Help
