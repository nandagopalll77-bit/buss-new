@echo off
setlocal
echo =========================================================
echo   SRI VIGNASEWRA SAREE HOUSE - Push To GitHub Script
echo =========================================================
echo.

:: Detect git or portable git
set GIT_CMD=git
where git >nul 2>nul
if %errorlevel% neq 0 (
    if exist "C:\Users\NANDA GOPAL\.gemini\antigravity\scratch\mingit\cmd\git.exe" (
        set "GIT_CMD=C:\Users\NANDA GOPAL\.gemini\antigravity\scratch\mingit\cmd\git.exe"
    ) else (
        echo [ERROR] Git was not found. Please install Git or check your setup.
        pause
        exit /b 1
    )
)

cd /d "C:\Users\NANDA GOPAL\.gemini\antigravity\scratch\sri-vignasewra-saree-house"

echo [*] Using Git: %GIT_CMD%
"%GIT_CMD%" status

echo.
echo =========================================================
echo Enter your GitHub Repository URL
echo Example: https://github.com/YOUR_USERNAME/sri-vignasewra-saree-house.git
echo =========================================================
set /p REPO_URL="Repository URL: "

if "%REPO_URL%"=="" (
    echo [!] No URL entered. Exiting.
    pause
    exit /b 0
)

:: Set remote origin
"%GIT_CMD%" remote remove origin >nul 2>nul
"%GIT_CMD%" remote add origin %REPO_URL%

echo.
echo [*] Pushing branch 'main' to %REPO_URL%...
"%GIT_CMD%" push -u origin main

if %errorlevel% equ 0 (
    echo.
    echo =========================================================
    echo [SUCCESS] Your website is now live on GitHub!
    echo =========================================================
    echo To enable free hosting on GitHub Pages:
    echo 1. Go to your repo on GitHub
    echo 2. Click Settings -^> Pages (under Code and automation)
    echo 3. Select branch: main, folder: / (root) -^> Save
) else (
    echo.
    echo [!] Push failed or requires authentication.
    echo Note: When prompted for password, enter your GitHub Personal Access Token (PAT).
)

echo.
pause
