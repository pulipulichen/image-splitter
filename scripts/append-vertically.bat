SET drive=%~d1
SET dir_path=%~p1
SET file_name=%~n1
SET ext_name=%~x1

for /F %%a in (%input%) do set search=%%a
ECHO %a
image_magick\convert.exe %1 -append "%drive%%dir_path%%file_name%-%%dout%ext_name%"
