import { Request, Response, NextFunction } from 'express';
import { log } from '../../services/logger';

export function errorHandler(
  err: any,
  req: Request,
  res: Response,
  next: NextFunction
): void {
  log.error('API error', {
    error: err.message,
    stack: err.stack,
    path: req.path,
    method: req.method,
  });

  const statusCode = err.status || err.statusCode || 500;
  const message = err.message || 'Erreur interne du serveur';

  res.status(statusCode).json({
    error: message,
    timestamp: new Date().toISOString(),
  });
}
