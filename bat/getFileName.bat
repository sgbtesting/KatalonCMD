@echo off
for /f "delims=" %%i in ('dir /b /a-d %1\%2') do set "result=%%i"
echo %result% > %3|type %3
