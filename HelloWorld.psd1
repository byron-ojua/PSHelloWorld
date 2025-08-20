@{
    RootModule        = 'HelloWorld.psm1'
    ModuleVersion     = '1.0.0'
    GUID              = '00062116-767c-4ba6-aa76-72ebeaed8898'
    Author            = 'Byron Ojua-Nice'
    Description       = 'Basic Hello World PowerShell Module Example'
    FunctionsToExport = @('HelloWorld','Write-Hello','Get-HelloInfo','Show-HelloHelp')
    CmdletsToExport   = @()
    VariablesToExport = @()
    AliasesToExport   = @()
}
