# Wandel deployment

This repository contains the Vite frontend and FastAPI backend. Deploy them as two Vercel projects.

## Frontend
- Vercel project root: `frontend`
- Build: `npm run build`
- Output: `dist`
- Environment variable: `VITE_API_BASE_URL=https://<backend>.vercel.app/api`

## Backend
- Vercel project root: `backend`
- Runtime: Python/FastAPI
- Environment variables: `DATABASE_URL`, `JWT_SECRET_KEY`, `GEMINI_API_KEY`, and `CORS_ORIGINS`
- `CORS_ORIGINS` should contain the frontend Vercel URL, comma-separated if needed.

Do not commit `.env` files or API keys.
