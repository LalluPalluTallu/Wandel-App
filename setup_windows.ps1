$ErrorActionPreference = "Stop"

Write-Host "Creating Python virtual environment..."
py -m venv .venv

Write-Host "Activating virtual environment..."
.\.venv\Scripts\Activate.ps1

Write-Host "Upgrading pip..."
python -m pip install --upgrade pip

Write-Host "Installing backend dependencies..."
pip install -r requirements.txt

if (!(Test-Path .env)) {
    Copy-Item .env.example .env
    Write-Host "Created .env from .env.example. Edit DATABASE_URL and JWT_SECRET_KEY before starting."
}

Write-Host "Setup complete. Start with: uvicorn app.main:app --reload"
