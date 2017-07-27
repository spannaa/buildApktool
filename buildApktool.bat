@echo off
mode con:cols=125 lines=40
if exist "Apktool\" rd /q /s "Apktool"
git clone git://github.com/iBotPeaches/Apktool.git
cd Apktool
echo.
echo Building apktool...
call gradlew.bat build shadowJar
echo.
cd "%~dp0"
echo.
echo Cleaning up...
copy "Apktool\brut.apktool\apktool-cli\build\libs\apktool-cli-all.jar" "apktool-cli-all.jar" > nul
if not exist "Extract\" mkdir "Extract"
cd tools
7za x -o"..\Extract" "..\apktool-cli-all.jar" > nul
cd "%~dp0"
copy "Extract\properties\apktool.properties" "apktool.properties" > nul
if exist "Extract\" rd /q /s "Extract"
for /f "tokens=*" %%a in ('find /i "application.version="^<apktool.properties') do set %%a
ren "apktool-cli-all.jar" "apktool_%application.version%.jar"
if exist "apktool.properties" del /f "apktool.properties"
if exist "Apktool\" rd /q /s "Apktool"
echo.
echo apktool_%application.version%.jar complete
echo.
pause
exit