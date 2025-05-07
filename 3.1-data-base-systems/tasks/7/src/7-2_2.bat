CD %PROGRAMDATA%
CD MySQL
CD "MySQL Server 8.0"
DIR

REM Modify a `my.ini` file in the environment like `my.ini` in this directory.

NET STOP MySQL
NET START MySQL
