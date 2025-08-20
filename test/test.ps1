# Import the module for direct use
Import-Module HelloWorld -Force

# Test direct function calls
Write-Hello
Write-Hello -Name John
Get-HelloInfo
Get-Help Write-Hello

# Test CLI wrapper (notice the & and script path)
& .\bin\HelloWorld.ps1 Help
& .\bin\HelloWorld.ps1 Hello
& .\bin\HelloWorld.ps1 Hello Byron
& .\bin\HelloWorld.ps1 Info
& .\bin\HelloWorld.ps1 Help Hello