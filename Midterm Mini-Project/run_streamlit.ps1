$ErrorActionPreference = "Stop"
$projectRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $projectRoot

if (-not (Test-Path "$projectRoot\.venv")) {
    py -3.14 -m venv .venv
}

& "$projectRoot\.venv\Scripts\Activate.ps1"
python -m pip install -r .\requirements.txt

if (-not (Test-Path "$projectRoot\.env")) {
    if (Test-Path "$projectRoot\.env.example") {
        Copy-Item "$projectRoot\.env.example" "$projectRoot\.env"
    }
}

python -m streamlit run .\app.py
