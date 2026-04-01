# Script de demarrage Taureau Celtique v3
# ========================================

param(
    [switch]$Stop,
    [switch]$Restart,
    [switch]$Status,
    [switch]$Logs,
    [switch]$Dev
)

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $ScriptDir

function Write-Header {
    Write-Host ""
    Write-Host "=== Taureau Celtique v3 - Manager ===" -ForegroundColor Cyan
    Write-Host ""
}

function Check-PM2 {
    $pm2 = Get-Command pm2 -ErrorAction SilentlyContinue
    if (-not $pm2) {
        Write-Host "PM2 n'est pas installe. Installation..." -ForegroundColor Yellow
        npm install -g pm2
    }
}

Write-Header

if ($Stop) {
    Write-Host "Arret du bot..." -ForegroundColor Yellow
    pm2 stop bot-v3
    exit
}

if ($Restart) {
    Write-Host "Redemarrage du bot..." -ForegroundColor Yellow
    pm2 restart bot-v3
    exit
}

if ($Status) {
    pm2 status
    exit
}

if ($Logs) {
    pm2 logs bot-v3
    exit
}

if ($Dev) {
    Write-Host "Lancement en mode dev (sans PM2)..." -ForegroundColor Green
    npm run dev
    exit
}

Check-PM2

Write-Host "Demarrage du bot..." -ForegroundColor Green
pm2 start ecosystem.config.js

Write-Host ""
Write-Host "Bot demarre avec succes!" -ForegroundColor Green
Write-Host ""
Write-Host "Commandes utiles:" -ForegroundColor Cyan
Write-Host "  .\start.ps1 -Status    # Voir le statut"
Write-Host "  .\start.ps1 -Logs      # Voir les logs"
Write-Host "  .\start.ps1 -Stop      # Arreter"
Write-Host "  .\start.ps1 -Restart   # Redemarrer"
Write-Host "  .\start.ps1 -Dev       # Mode dev (sans PM2)"
Write-Host ""

pm2 status
