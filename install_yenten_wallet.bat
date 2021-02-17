@echo off
setlocal enableextensions
color 9

cls

echo #######################################
echo # Welcome to YENTEN Wallet Installer! #
echo #######################################
echo #
set /P tempdestination="# Enter destination (C:\YENTEN Wallet): "
IF "%tempdestination%" == "" (
	set tempdestination=C:\YENTEN Wallet
)

:tryagain
if exist "%tempdestination%" (
  if %PROCESSOR_ARCHITECTURE%==x86 (
    echo #
	echo # Buy a computer
	echo #
	) else (
	 cls
	  echo #############################
	  echo # Downloading Wallet App... #
	  echo #############################
	  echo #
	  wget.exe -P "%installdir%" -nc https://github.com/yentencoin/yenten/releases/download/4.0.1/yenten-4.0.1.2-win64.zip  -q --show-progress
	  echo #
	  echo ############################
	  echo # Extracting Wallet App... #
	  echo ############################
	  echo #
	  unzip.exe "%installdir%\yenten-4.0.1.2-win64.zip" -d "%installdir%"

	  rem Make data directory
	  MD "%installdir%\data"
	  
	  cls
	  echo ###############################################
	  echo # Downloading YENTEN Blockchain 17.02.2021... #
	  echo ###############################################
	  echo #
	  wget -O "%installdir%\blockchain.rar" "https://www.dropbox.com/s/w5emmxsqg0f3ymv/yenten_blockchain_data_170221.rar?dl=1" -q --show-progress
	  
	  echo #
	  echo ###############################################
	  echo Extracting YENTEN Blockchain...
	  echo ###############################################
	  echo #
	  unrar.exe x -idd -y -o+ -ilog "%installdir%\blockchain.rar" *.* "%installdir%\data\"
	  
	  rem delete tmp files
	  del /F /Q "%installdir%\blockchain.rar"
	  del /F /Q "%installdir%\yenten-4.0.1.2-win64.zip"
	  del /F /Q .wget-hsts
	  
	  rem create icon
	  nircmd shortcut "%installdir%\yenten-qt.exe" "~$folder.desktop$" "YENTEN Wallet" "" "%installdir%\yenten-qt.exe" 
	  	  
	  cls
	  echo ######################
	  echo # Starting Wallet... #
	  echo ######################

	  start "YENTEN Wallet" /D "%installdir%" /B yenten-qt.exe -choosedir
	  
	  echo #
	  echo #########################
	  echo # Installation complete #
	  echo # Enjoy CPU-MINING!     #
	  echo #########################
	  echo #
	)
 ) else (
	  echo #
	  echo # Creating Folder...
	  echo #
	  MD "%tempdestination%"
	  cd %tempdestination%
	  SET installdir=%cd%\%tempdestination%
	  cd %~dp0
	  goto tryagain
	)

endlocal

pause