#!/bin/bash
# =============================================================================
# SCRIPT DE DEPLOIEMENT - Taureau Celtique v3
# =============================================================================
# Usage: ./deploy.sh [option]
#
# Options:
#   --install     Installation complete (premiere fois)
#   --update      Mise a jour et redemarrage
#   --restart     Redemarrage seulement
#   --stop        Arreter le bot
#   --status      Voir le statut
#   --logs        Voir les logs
#   --db-push     Synchroniser le schema Prisma
#   --deploy-cmd  Deployer les commandes slash Discord
#   --help        Afficher cette aide
# =============================================================================

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"
LOG_FILE="$SCRIPT_DIR/deploy.log"

log()  { echo -e "${GREEN}[$(date '+%Y-%m-%d %H:%M:%S')]${NC} $1" | tee -a "$LOG_FILE"; }
warn() { echo -e "${YELLOW}[WARNING]${NC} $1" | tee -a "$LOG_FILE"; }
err()  { echo -e "${RED}[ERROR]${NC} $1" | tee -a "$LOG_FILE"; exit 1; }
header() {
    echo ""
    echo -e "${CYAN}=============================================${NC}"
    echo -e "${CYAN}   $1${NC}"
    echo -e "${CYAN}=============================================${NC}"
    echo ""
}

check_prerequisites() {
    header "Verification des prerequis"

    command -v node &> /dev/null || err "Node.js n'est pas installe."
    NODE_VERSION=$(node -v | cut -d'v' -f2 | cut -d'.' -f1)
    [ "$NODE_VERSION" -ge 22 ] || err "Node.js 22+ requis. Version actuelle: $(node -v)"
    log "Node.js: $(node -v)"

    command -v npm &> /dev/null || err "npm n'est pas installe."
    log "npm: $(npm -v)"

    if ! command -v pm2 &> /dev/null; then
        warn "PM2 n'est pas installe. Installation..."
        npm install -g pm2
    fi
    log "PM2: $(pm2 -v)"
}

check_env() {
    header "Verification du .env"

    [ -f ".env" ] || err "Fichier .env manquant!"
    log ".env: present"

    grep -q "BOT_TOKEN=" .env || err "BOT_TOKEN manquant dans .env"
    grep -q "DATABASE_URL=" .env || err "DATABASE_URL manquant dans .env"
    log "Variables critiques: presentes"
}

install_deps() {
    header "Installation des dependances"
    npm install --production=false
    log "Dependances installees!"
}

generate_prisma() {
    header "Generation du client Prisma"
    npx prisma generate
    log "Client Prisma genere!"
}

push_database() {
    header "Synchronisation de la base de donnees"
    npx prisma db push
    log "Base de donnees synchronisee!"
}

deploy_commands() {
    header "Deploiement des commandes Discord"
    npx tsx src/deploy-commands.ts
    log "Commandes Discord deployees!"
}

start_bot() {
    header "Demarrage du bot"
    pm2 delete bot-v3 2>/dev/null || true
    pm2 start ecosystem.config.js
    pm2 save
    log "Bot demarre!"
    pm2 status
}

full_install() {
    header "INSTALLATION COMPLETE"
    check_prerequisites
    check_env
    install_deps
    generate_prisma
    push_database
    deploy_commands
    start_bot

    echo ""
    echo -e "${GREEN}=============================================${NC}"
    echo -e "${GREEN}   INSTALLATION TERMINEE!${NC}"
    echo -e "${GREEN}=============================================${NC}"
    echo ""
    echo -e "${CYAN}Endpoints:${NC}"
    echo -e "  Bot API:    ${GREEN}http://localhost:3008${NC}"
    echo -e "  WebSocket:  ${GREEN}ws://localhost:3009${NC}"
    echo ""
}

update() {
    header "MISE A JOUR"
    install_deps
    generate_prisma
    pm2 restart bot-v3
    log "Mise a jour terminee!"
}

case "${1:-}" in
    --install|-i)   full_install ;;
    --update|-u)    update ;;
    --restart|-r)   pm2 restart bot-v3 && pm2 status ;;
    --stop|-s)      pm2 stop bot-v3 && pm2 status ;;
    --status)       pm2 status ;;
    --logs|-l)      pm2 logs bot-v3 ;;
    --db-push)      push_database ;;
    --deploy-cmd)   deploy_commands ;;
    --help|-h)
        echo ""
        echo -e "${CYAN}Taureau Celtique v3 - Deploiement${NC}"
        echo ""
        echo "Usage: ./deploy.sh [option]"
        echo ""
        echo "  --install      Installation complete"
        echo "  --update       Mise a jour + redemarrage"
        echo "  --restart      Redemarrage seulement"
        echo "  --stop         Arreter le bot"
        echo "  --status       Statut des services"
        echo "  --logs         Logs en temps reel"
        echo "  --db-push      Synchroniser la BDD"
        echo "  --deploy-cmd   Deployer les commandes Discord"
        echo "  --help         Cette aide"
        echo ""
        ;;
    *)
        echo -e "${YELLOW}Aucune option. Utilisez --help pour voir les options.${NC}"
        echo ""
        pm2 status 2>/dev/null || echo "PM2 non demarre."
        ;;
esac
