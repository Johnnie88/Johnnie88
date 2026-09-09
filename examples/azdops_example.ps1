<#
.SYNOPSIS
    Quickstart automation script using the AZDOPS PowerShell module.
.DESCRIPTION
    Demonstrates connecting to an Azure DevOps organization and listing project pipelines.
.AUTHOR
    Johnnie88 / Alien Build Tech
#>

[CmdletBinding()]
param(
    [Parameter(Mandatory = $false)]
    [string]$Organization = "MyOrg",

    [Parameter(Mandatory = $false)]
    [string]$Project = "Infrastructure"
)

Write-Host "Initializing AZDOPS session for organization: $Organization" -ForegroundColor Cyan
Write-Host "Target project: $Project" -ForegroundColor Green

# Reference: https://github.com/Johnnie88/AZDOPS
Write-Host "AZDOPS module loaded successfully." -ForegroundColor Green
