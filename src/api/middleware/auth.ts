import { Request, Response, NextFunction } from 'express';
import { log } from '../../services/logger';

export interface AuthRequest extends Request {
  user?: any;
}

export function authenticateToken(
  req: AuthRequest,
  res: Response,
  next: NextFunction
): void {
  const authHeader = req.headers['authorization'];
  const token = authHeader && authHeader.split(' ')[1];

  if (!token) {
    log.api(req.method, req.path, 401, { error: 'Token missing' });
    res.status(401).json({ error: "Token d'acces requis" });
    return;
  }

  const validToken = process.env.BOT_API_TOKEN;

  if (!validToken) {
    log.error('BOT_API_TOKEN not defined in .env');
    res.status(500).json({ error: 'Configuration serveur invalide' });
    return;
  }

  if (token !== validToken) {
    log.api(req.method, req.path, 403, { error: 'Invalid token' });
    res.status(403).json({ error: 'Token invalide' });
    return;
  }

  req.user = { authenticated: true };
  next();
}
