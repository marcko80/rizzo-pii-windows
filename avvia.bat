@echo off
setlocal
title Rizzo PII - avvio
cd /d "%~dp0"

echo ============================================================
echo   Rizzo PII - avvio rapido per Windows
echo   (per chi non conosce Python: basta lasciare fare a questo script)
echo ============================================================
echo.

where py >nul 2>nul
if %errorlevel%==0 (
    set "PYCMD=py"
) else (
    where python >nul 2>nul
    if %errorlevel%==0 (
        set "PYCMD=python"
    ) else (
        echo ERRORE: Python non e' installato oppure non e' nel PATH di sistema.
        echo Scarica e installa Python 3.10 o superiore da:
        echo   https://www.python.org/downloads/
        echo Durante l'installazione, spunta la casella "Add python.exe to PATH".
        echo.
        pause
        exit /b 1
    )
)

if not exist ".venv\Scripts\python.exe" (
    echo Prima esecuzione: creo l'ambiente Python isolato nella cartella .venv ...
    %PYCMD% -m venv .venv
    if errorlevel 1 (
        echo ERRORE durante la creazione dell'ambiente virtuale.
        pause
        exit /b 1
    )
    echo Installo le librerie necessarie da requirements.txt, un momento...
    ".venv\Scripts\python.exe" -m pip install --upgrade pip >nul
    ".venv\Scripts\python.exe" -m pip install -r requirements.txt
    if errorlevel 1 (
        echo ERRORE durante l'installazione delle librerie richieste.
        pause
        exit /b 1
    )
)

echo Avvio il server locale: il browser si aprira' automaticamente su http://127.0.0.1:5005
echo Per chiudere l'app, chiudi semplicemente questa finestra.
echo.
".venv\Scripts\python.exe" src\app\app.py

pause

