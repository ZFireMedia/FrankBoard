<#
.SYNOPSIS
    Run a command on the FrankBoard VPS. Used by Cursor Agent for deploys and maintenance.
.DESCRIPTION
    Invokes ssh with the frankboard-vps config. Path: /root/frankboard.
    Use -Command for one-off commands, -DeployWave1 for Wave 1 deploy.
.EXAMPLE
    .\run-vps.ps1 -Command "cd /root/frankboard && pwd"
.EXAMPLE
    .\run-vps.ps1 -DeployWave1
#>
param(
    [Parameter(ParameterSetName = "Command")]
    [string]$Command,
    [Parameter(ParameterSetName = "Deploy")]
    [switch]$DeployWave1,
    [Parameter(ParameterSetName = "Deploy")]
    [switch]$DeploySite,
    [int]$TimeoutSeconds = 120
)

$ErrorActionPreference = "Stop"
$vpsHost = "frankboard-vps"
$repoPath = "/root/frankboard"

if ($DeploySite) {
    $Command = "cd $repoPath && git pull && chmod +x scripts/deploy-site.sh && ./scripts/deploy-site.sh"
}

if ($DeployWave1) {
    $Command = "cd $repoPath && git pull && chmod +x scripts/deploy-wave1.sh && ./scripts/deploy-wave1.sh"
}

if (-not $Command) {
    Write-Error "Use -Command '...' or -DeployWave1"
    exit 1
}

Write-Host "Running on $vpsHost : $Command"
$sshArgs = @(
    "-o", "BatchMode=yes",
    "-o", "ConnectTimeout=10",
    "-o", "StrictHostKeyChecking=accept-new",
    $vpsHost,
    $Command
)
& ssh @sshArgs
