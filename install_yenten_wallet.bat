@ECHO off                               
COLOR 9
CLS
SETLOCAL enableextensions

ECHO #######################################
ECHO # Welcome to YENTEN Wallet Installer! #
ECHO #######################################
ECHO #

SET /P TempDestination=# Enter destination (%CD%): 
IF "%TempDestination%"=="" (
SET TempDestination=%CD%  
)     
ECHO #
ECHO # Creating Folder...
ECHO #
MD "%TempDestination%"

cd /D %TempDestination%
SET InstallDir=%CD%
CHDIR /D %~dp0

ECHO # %InstallDir%

CLS
ECHO #############################
ECHO # Downloading Wallet App... #
ECHO #############################
ECHO #
wget.exe -P "%InstallDir%" -nc https://github.com/yentencoin/yenten/releases/download/4.0.3/yenten-4.0.3.1-win64.zip  -q --show-progress
	
ECHO #
ECHO ############################
ECHO # Extracting Wallet App... #
ECHO ############################
ECHO #
unzip.exe "%InstallDir%\yenten-4.0.3.1-win64.zip" -d "%InstallDir%"
rem MOVE "%InstallDir%\yenten-wallet\*.*" "%InstallDir%"

rem Make data directory
MD "%InstallDir%\data"

CLS
ECHO ################################################
ECHO # Downloading YENTEN Blockchain (bootstrap)... #
ECHO ################################################
ECHO #
wget -O "%InstallDir%\blockchain.rar" "https://github.com/ChervyachokMigo/YENTEN-WALLET-EASY-INSTALLER/releases/download/bootstrap/bootstrap.rar" -q --show-progress

ECHO #
ECHO ###############################################
ECHO Extracting YENTEN Blockchain...
ECHO ###############################################
ECHO #
unrar.exe x -idd -y -o+ -ilog "%InstallDir%\blockchain.rar" *.* "%InstallDir%\data\"

rem delete tmp files
del /F /Q "%InstallDir%\blockchain.rar"
del /F /Q "%InstallDir%\yenten-4.0.3.1-win64.zip"
del /F /Q .wget-hsts
rem rmdir "%InstallDir%\yenten-4.0.2-win64"

rem create icon
nircmd shortcut "%InstallDir%\yenten-qt.exe" "~$folder.desktop$" "YENTEN Wallet" "" "%InstallDir%\yenten-qt.exe" 
nircmd shortcut "%InstallDir%\yenten-qt.exe" "~$folder.desktop$" "CHOOSE DATA - YENTEN Wallet AND START WALLET" "-choosedatadir" "%InstallDir%\yenten-qt.exe" 
  
CLS
ECHO ######################
ECHO # Starting Wallet... #
ECHO ######################

start "YENTEN Wallet" /D "%InstallDir%" /B yenten-qt.exe -choosedatadir

COLOR C

ECHO #
ECHO #################################################
ECHO #  Choose 'data' folder under wallet directory  #
ECHO #  when wallet will start and prompt it         #
ECHO #################################################

pause

CLS
COLOR A

ECHO #########################
ECHO # Installation complete #
ECHO # Enjoy CPU-MINING!     #
ECHO #########################        
                   
pause

endlocal

COLOR 0F

exit /B
