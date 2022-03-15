:: checkerrors.bat
:: by Candice Manganar
::
:: Looks for non-zero exit code in the log file.
:: If non-zero exit code found, script returns exit 1 (fail), else returns exit 0 (success).

@echo off
echo ============================================================
findstr /R /C:"exited with code [^0]" ..\..\jobs\%JOB_NAME%\builds\%BUILD_NUMBER%\log


if %ERRORLEVEL%==0 (
  echo ============================================================
  echo                       ERRORS FOUND!
  echo ============================================================
  exit /B 1
) else (
  exit /B 0
)

::#!/bin/bash
::
::grep "exited with code [1-9]" ../../jobs/$JOB_NAME/builds/$BUILD_NUMBER/log
::
::if(($?==0))
::then
::  echo ============================================================
::  echo                       ERRORS FOUND!
::  echo ============================================================
::  exit 1
::else
::  exit 0
::fi