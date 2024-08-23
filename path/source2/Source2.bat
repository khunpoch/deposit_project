@echo off
REM กำหนดตัวแปรสำหรับ Oracle
set ORACLE_HOME=C:\app\oracle\product\12.2.0\dbhome_1
set PATH=%ORACLE_HOME%\bin;%PATH%

REM กำหนดโฟลเดอร์ที่เก็บไฟล์ CSV
set CSV_DIR=C:\path\source2\csv_file
set TEMP_CSV_FILE=%CSV_DIR%\latest_file.csv

REM ค้นหาไฟล์ CSV ที่มีวันที่แก้ไขล่าสุด
set LATEST_CSV_FILE=
for /f "delims=" %%i in ('dir /b /a-d /o-d /t:w "%CSV_DIR%\*.csv"') do (
    set LATEST_CSV_FILE=%%i
    goto :break
)
:break

REM ตรวจสอบว่าเจอไฟล์หรือไม่
if "%LATEST_CSV_FILE%"=="" (
    echo ไม่พบไฟล์ CSV.
    exit /b 1
)

REM คัดลอกไฟล์ล่าสุดไปยังตำแหน่งชั่วคราว
copy "%CSV_DIR%\%LATEST_CSV_FILE%" "%TEMP_CSV_FILE%"

REM กำหนดตัวแปรอื่นๆ
set CONTROL_FILE=C:\path\source2\CONTROL_FILE\source_control_2.ctl
set LOG_FILE=C:\path\source2\LOG_FILE\log_file.log
set BAD_FILE=C:\path\source2\BAD_FILE\bad_file.bad


REM รัน SQL*Loader
sqlldr userid=username/password@database control=%CONTROL_FILE% data=%TEMP_CSV_FILE% log=%LOG_FILE% bad=%BAD_FILE% 

REM ลบไฟล์ชั่วคราว
del %TEMP_CSV_FILE%
