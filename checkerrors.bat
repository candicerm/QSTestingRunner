cd
@echo off
echo "******************CM: PARAMS*********************"
echo %JOB_NAME%
echo %BUILD_NUMBER%

findstr /R /C:"exited with code [^0]" ./var/jenkins_home/jobs/%JOB_NAME%/builds/%BUILD_NUMBER%/log


if %ERRORLEVEL%==0 (
  echo "***************************"
  echo "*    CM: Errors found!    *"
  echo "***************************"
  exit /B 1
) else (
  exit /B 0
)