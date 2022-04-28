:: timestamp.bat
:: by Candice Manganar
::
:: Returns the timestamp in yyyyMMddHHmm format

@echo off
tzutil /s "Eastern Standard Time"
For /f "tokens=1-3 delims=:/" %%a in ("%DATE%") do (set mydate=%%c%%a%%b)
For /f "tokens=1-2 delims=:" %%a in ("%TIME: =0%") do (set mytime=%%a%%b)
echo %mydate%%mytime%

::date '+%Y%m%d%H%M'
::myd=$(date '+%Y%m%d%H%M')
::echo $myd 
