@echo off
setlocal enabledelayedexpansion
title Brute force
mode 300

set ESC=
set RD=%ESC%[31m
set GN=%ESC%[32m
set YW=%ESC%[33m
set BL=%ESC%[34m
set WT=%ESC%[37m
set RN=%ESC%[0m
rem username - admin password - password
set "hashed_username=c7ad44cbad762a5da0a452f9e854fdc1e0e7a52a38015f23f3eab1d80b931dd472634dfac71cd34ebc35d16ab7fb8a90c81f975113d6c7538dc69dd8de9077ec"
set "hashed_password=b109f3bbbc244eb82441917ed06d618b9008dd09b3befd1b5e07394c706a8bb980b1d7785e5976ec049b46df5f1326af5a2ea6d103fd07c95385ffab0cacbc86"

:login
cls
echo Please log in:
echo %YW%Username: %RN%
set /p "inputUsername="
echo %YW%Password: %RN%
set /p "inputPassword="

call :hash_word "SHA512" "%inputUsername%" hashedInputUsername
call :hash_word "SHA512" "%inputPassword%" hashedInputPassword

if "%hashedInputUsername%"=="%hashed_username%" (
    if "%hashedInputPassword%"=="%hashed_password%" (
        echo %GN%Login successful.%RN%
        timeout /t 1 >nul
        goto menu
    )
)

echo %RD%Login failed. Please try again.%RN%
timeout /t 1 >nul
goto login

:menu
cls
type ".\ascii_art\art.txt"
echo ---------------
echo   Main Menu
echo ---------------
echo 1. Brute Force
echo 2. Encrypt string
echo 3. Exit
echo ---------------
set /p choice="Enter your choice (1-3): "

if "%choice%"=="1" goto BruteForce
if "%choice%"=="2" goto Encrypt
if "%choice%"=="3" goto exit

echo Invalid choice. Please try again.
pause
goto menu

:BruteForce
cls
type ".\ascii_art\encryption_art.txt"
echo --------------
echo   BruteForce
echo --------------
echo %YW%What is the hash type?%RN%
echo 1. MD5
echo 2. SHA1
echo 3. SHA256
echo 4. SHA384
echo 5. SHA512
echo 6. Back
echo ---------------
set /p choice="Enter your choice (1-6): "

if "%choice%"=="1" (
    set "hashAlgorithm=MD5"
) else if "%choice%"=="2" (
    set "hashAlgorithm=SHA1"
) else if "%choice%"=="3" (
    set "hashAlgorithm=SHA256"
) else if "%choice%"=="4" (
    set "hashAlgorithm=SHA384"
) else if "%choice%"=="5" (
    set "hashAlgorithm=SHA512"
) else if "%choice%"=="6" (
    goto menu
) else (
    echo Invalid choice. Please try again.
    pause
    goto BruteForce
)

echo %YW%Select the wordlist:%RN%
set "counter=0"
for %%f in (word_lists\*) do (
    set /a counter+=1
    echo !counter!. %%~nxf
    set "file_!counter!=%%f"
)

set /p choice="Enter the number of the wordlist: "
set "file=!file_%choice%!"

if not defined file (
    echo Invalid choice. Please try again.
    pause
    goto BruteForce
)

set /p target_hash="Enter the hash you want to try to decrypt: "

for /f "usebackq delims=" %%i in ("%file%") do (
    echo %%i
    call :hash_word "%hashAlgorithm%" "%%i" hash
    if "!hash!"=="%target_hash%" (
        echo The answer is %%i
        pause
        goto menu
    )
)

echo No match found.
pause
goto menu


:Encrypt
cls
type ".\ascii_art\encryption_art.txt"
echo ------------------
echo   Encrypt string
echo ------------------
echo 1. MD5
echo 2. SHA1
echo 3. SHA256
echo 4. SHA384
echo 5. SHA512
echo 6. back
echo ---------------
set /p choice="Enter your choice (1-6): "

if "%choice%"=="1" (
    set "hashAlgorithm=MD5"
) else if "%choice%"=="2" (
    set "hashAlgorithm=SHA1"
) else if "%choice%"=="3" (
    set "hashAlgorithm=SHA256"
) else if "%choice%"=="4" (
    set "hashAlgorithm=SHA384"
) else if "%choice%"=="5" (
    set "hashAlgorithm=SHA512"
) else if "%choice%"=="6" (
    goto menu
) else (
    echo Invalid choice. Please try again.
    pause
    goto Encrypt
)

set /p "inputString=Enter a string to calculate its hash: "

call :hash_word "%hashAlgorithm%" "%inputString%" hash

echo %hashAlgorithm% Hash of "%inputString%" is: %hash%
pause
goto menu

:exit
echo Bye :(
timeout /t 5
exit /b

:hash_word
setlocal
set "algorithm=%~1"
set "input=%~2"
set "output_var=%~3"

for /f %%h in ('powershell -NoProfile -Command "([System.BitConverter]::ToString([System.Security.Cryptography.HashAlgorithm]::Create('%algorithm%').ComputeHash([System.Text.Encoding]::UTF8.GetBytes('%input%')))).Replace('-','').ToLower()"') do (
    set "hash=%%h"
)

endlocal & set "%output_var%=%hash%"
goto :eof
