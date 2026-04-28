param(
    [Parameter(Mandatory = $false)]
    [string]$TestFile = "",

    [Parameter(Mandatory = $false)]
    [switch]$All,

    [Parameter(Mandatory = $false)]
    [switch]$Parallel,

    [Parameter(Mandatory = $false)]
    [switch]$Allure,

    # ── Excel-driven environment selection ────────────────────────────────────
    # Matches a column name in the Environments sheet of data/TestData.xlsx.
    # Valid values: DEV (default) | QA | PROD
    [Parameter(Mandatory = $false)]
    [ValidateSet("DEV", "QA", "PROD")]
    [string]$Env = "DEV",

    # ── Python Executable ─────────────────────────────────────────────────────
    [Parameter(Mandatory = $false)]
    [string]$PythonExe = "python"
)

$TestDir     = "$PSScriptRoot\..\testscenarios"
$ReportsDir  = "$PSScriptRoot\..\reports"
$AllureResults = "$ReportsDir\allure-results"
$Listener    = "allure_robotframework;$AllureResults"

# Pass selected ENV to every robot invocation so env.resource picks it up
$EnvVar = "--variable ENV:$Env"

Write-Host "  Environment : $Env" -ForegroundColor DarkCyan
Write-Host "  Python Exe  : $PythonExe" -ForegroundColor DarkCyan
Write-Host "  TestDir     : $TestDir" -ForegroundColor DarkCyan
Write-Host "  ReportsDir  : $ReportsDir`n" -ForegroundColor DarkCyan

# ── helpers ──────────────────────────────────────────────────────────────────
function Run-Single {
    param([string]$File)
    $path = "$TestDir\$File"
    if (-not (Test-Path $path)) { $path = $File }
    if (-not (Test-Path $path)) { Write-Error "File not found: $File"; exit 1 }

    Write-Host "▶  Running  : $path" -ForegroundColor Cyan
    if ($Allure) {
        & $PythonExe -m robot --listener $Listener --variable ENV:$Env --pythonpath "$PSScriptRoot" -d $ReportsDir $path
    }
    else {
        & $PythonExe -m robot --variable ENV:$Env --pythonpath "$PSScriptRoot" -d $ReportsDir $path
    }
}

function Run-All {
    Write-Host "▶  Running ALL tests in '$TestDir'" -ForegroundColor Cyan
    if ($Allure) {
        & $PythonExe -m robot --listener $Listener --variable ENV:$Env --pythonpath "$PSScriptRoot" -d $ReportsDir $TestDir
    }
    else {
        & $PythonExe -m robot --variable ENV:$Env --pythonpath "$PSScriptRoot" -d $ReportsDir $TestDir
    }
}

function Run-Parallel {
    Write-Host "▶  Running ALL tests in PARALLEL with pabot" -ForegroundColor Cyan
    
    if ($Allure) {
        & $PythonExe -m pabot.pabot --outputdir $ReportsDir --listener $Listener --variable ENV:$Env --pythonpath "$PSScriptRoot" $TestDir
    }
    else {
        & $PythonExe -m pabot.pabot --outputdir $ReportsDir --variable ENV:$Env --pythonpath "$PSScriptRoot" $TestDir
    }
}

# ── serve allure ─────────────────────────────────────────────────────────────
function Serve-Allure {
    Write-Host "`n▶  Opening Allure Report..." -ForegroundColor Yellow
    npx.cmd allure serve $AllureResults
}

# ── main ─────────────────────────────────────────────────────────────────────
if ($Parallel) {
    Run-Parallel
}
elseif ($All) {
    Run-All
}
elseif ($TestFile -ne "") {
    Run-Single -File $TestFile
}
else {
    Write-Host @"

Usage:
  .\robot_run.ps1 -TestFile sp_BDD.robot              # run a single file  (DEV env)
  .\robot_run.ps1 -TestFile sp_BDD.robot -Env QA      # run with QA env
  .\robot_run.ps1 -All                                 # run all tests (DEV)
  .\robot_run.ps1 -All -Env PROD                       # run all tests (PROD)
  .\robot_run.ps1 -Parallel                            # parallel run (pabot)
  .\robot_run.ps1 -All -PythonExe "C:\myenv\python.exe" # specify python path

Add -Allure to any of the above to generate an Allure report, e.g.:
  .\robot_run.ps1 -TestFile sp_BDD.robot -Allure
  .\robot_run.ps1 -All -Allure -Env QA

To view the Allure report after a run:
  npx.cmd allure serve reports\allure-results

Environment values (set in data\TestData.xlsx  ->  Environments sheet):
  DEV   -- headless=false, APP_USERNAME=admin
  QA    -- headless=true,  APP_USERNAME=qa_admin
  PROD  -- headless=true,  APP_USERNAME=prod_admin

"@ -ForegroundColor Green
}

