/**
 * PM2 Ecosystem Configuration - Taureau Celtique v3
 * ==================================================
 *
 * Commandes:
 *   pm2 start ecosystem.config.js          # Demarrer le bot
 *   pm2 stop bot-v3                        # Arreter
 *   pm2 restart bot-v3                     # Redemarrer
 *   pm2 logs bot-v3                        # Logs en temps reel
 *   pm2 monit                              # Interface monitoring
 */

const path = require('path');
const isWindows = process.platform === 'win32';

module.exports = {
  apps: [
    {
      name: 'bot-v3',
      script: path.join(__dirname, 'node_modules/.bin', isWindows ? 'tsx.cmd' : 'tsx'),
      args: 'watch src/index.ts',
      cwd: __dirname,
      watch: false,
      autorestart: true,
      max_restarts: 10,
      restart_delay: 5000,
      env: {
        NODE_ENV: 'development',
      },
      env_production: {
        NODE_ENV: 'production',
      },
      // Logs
      log_file: path.join(__dirname, 'logs/pm2-combined.log'),
      out_file: path.join(__dirname, 'logs/pm2-out.log'),
      error_file: path.join(__dirname, 'logs/pm2-error.log'),
      log_date_format: 'YYYY-MM-DD HH:mm:ss Z',
      merge_logs: true,
      // Memoire
      max_memory_restart: '500M',
      instance_var: 'INSTANCE_ID',
    },
  ],
};
