# Walder Backend

FastAPI + PostgreSQL backend for the Walder React app.

## Features
- Registration and JWT login
- User profile and role (student / working professional)
- Daily tasks and role-aware task filtering
- Task completion with idempotent completion records
- XP transactions and totals
- Current/longest streak calculation
- Global and squad leaderboards
- Squads: create, join by invite code, leave, members
- Badges and automatic badge awarding
- Activity events for future ML training
- Basic recommendation endpoint using a deterministic baseline (replace with ML later)
- CORS for the Vite frontend
- Automatic table creation on startup for local development

## Important
This is a development-ready backend starter, not a production security/compliance package. Before production, add migrations (Alembic), rate limiting, email verification/password reset, stronger secret management, HTTPS, logging/monitoring, tests, and a production deployment configuration.
