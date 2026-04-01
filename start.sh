#!/bin/bash
# Script de demarrage Taureau Celtique v3
# ========================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

print_header() {
    echo ""
    echo -e "${CYAN}╔════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║       Taureau Celtique v3 - Manager       ║${NC}"
    echo -e "${CYAN}╚════════════════════════════════════════════╝${NC}"
    echo ""
}

check_pm2() {
    if ! command -v pm2 &> /dev/null; then
        echo -e "${YELLOW}PM2 n'est pas installe. Installation...${NC}"
        npm install -g pm2
    fi
}

print_header

case "$1" in
    "stop")
        echo -e "${YELLOW}Arret du bot...${NC}"
        pm2 stop bot-v3
        ;;
    "restart")
        echo -e "${YELLOW}Redemarrage du bot...${NC}"
        pm2 restart bot-v3
        ;;
    "status")
        pm2 status
        ;;
    "logs")
        pm2 logs bot-v3
        ;;
    "dev")
        echo -e "${GREEN}Lancement en mode dev (sans PM2)...${NC}"
        npm run dev
        ;;
    *)
        check_pm2
        echo -e "${GREEN}Demarrage du bot...${NC}"
        pm2 start ecosystem.config.js
        echo ""
        echo -e "${GREEN}Bot demarre avec succes!${NC}"
        echo ""
        echo -e "${CYAN}Commandes utiles:${NC}"
        echo "  ./start.sh status    # Voir le statut"
        echo "  ./start.sh logs      # Voir les logs"
        echo "  ./start.sh stop      # Arreter"
        echo "  ./start.sh restart   # Redemarrer"
        echo "  ./start.sh dev       # Mode dev (sans PM2)"
        echo ""
        pm2 status
        ;;
esac
