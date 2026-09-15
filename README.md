# Wandel — full-stack app (frontend wired to backend)

This is your FastAPI backend and React frontend, now actually talking to each
other over a real HTTP API (previously the frontend was a static mock with
no network calls at all).

## What changed

**Backend (`backend/`)**
- Fixed a bug: `app/seed.py` defined `seed_data()` but nothing called it, so
  the `tasks` table was always empty. `app/main.py` now seeds baseline
  tasks/badges on startup.
- Otherwise unchanged — I ran it end-to-end against a real Postgres instance
  and confirmed every endpoint (register, login, tasks, complete, profile,
  leaderboard, squads) works correctly.

**Frontend (`frontend/`)**
- New `src/api.js`: a small fetch client for the backend (JWT stored in
  `localStorage`, base URL from `VITE_API_BASE_URL`).
- `src/Wandel.jsx` (renamed from the uploaded file): replaced all mock state
  with real API calls.
  - **Onboarding** now collects email + password and calls
    `POST /api/auth/register`, plus a login mode for returning users
    (`POST /api/auth/login`).
  - **Home** loads today's task from `GET /api/tasks/today` and completes it
    via `POST /api/tasks/{id}/complete`, then refreshes your real XP/streak.
  - **Leaderboard** loads from `GET /api/leaderboard?view=global|squad`.
  - **Squad** loads/creates/joins/leaves via `/api/squads/*`.
  - **Profile** shows your real XP, streak, squad rank, and earned badges.
  - The monthly streak heatmap and the AI coach chat bubble are **still
    mocked** — the backend has no endpoints for daily-history or chat yet.
    Both are clearly commented in the code for when you add those.
- I added a minimal Vite scaffold (`package.json`, `vite.config.js`,
  `index.html`, `src/main.jsx`, Tailwind config) since only the component
  file had been uploaded before.

I ran the backend against a real local Postgres and the frontend against a
Vite dev server together in a sandbox and confirmed the full round trip
(register → see task → complete task → XP/streak update → leaderboard →
create squad) works.

## Running it yourself

### 1. Backend

```bash
cd backend
python3 -m venv venv
source venv/bin/activate      # Windows: venv\Scripts\activate
pip install -r requirements.txt
```

You need a local Postgres database matching `.env`:

```
DATABASE_URL=postgresql+psycopg://walder_user:Walder123!@localhost:5432/walder_db
```

Create it (adjust if you already have Postgres set up differently):

```sql
CREATE USER walder_user WITH PASSWORD 'Walder123!';
CREATE DATABASE walder_db OWNER walder_user;
```

Then start the API:

```bash
uvicorn app.main:app --reload --port 8000
```

Visit `http://localhost:8000/docs` to confirm it's up.

### 2. Frontend

```bash
cd frontend
npm install
npm run dev
```

Visit `http://localhost:5173`. It talks to `http://localhost:8000/api` by
default (see `frontend/.env`, `VITE_API_BASE_URL`).

### Both at once

Run the two commands above in two terminals — the backend must be running
before the frontend can register/log in.

## Known gaps (not addressed here, flagged for you)

- No migrations (Alembic) — tables are created via `create_all` on startup.
- No password reset / email verification.
- The activity heatmap and AI coach are UI-only; wire them to real endpoints
  when you build them.
- Windows: the zipped backend upload included a `.venv` built for Windows —
  I removed it here since venvs aren't portable between OS/Python builds;
  create a fresh one per the steps above.
