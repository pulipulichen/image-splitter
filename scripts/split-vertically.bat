@FOR /F "tokens=*" %%i IN ('ini.bat config.ini config page_is_left_to_right') DO set page_is_left_to_right=%%i
@FOR /F "tokens=*" %%i IN ('ini.bat config.ini config delete_after_converting') DO set delete_after_converting=%%i

SET drive=%~d1
SET dir_path=%~p1
SET file_name=%~n1
SET ext_name=%~x1
image_magick\convert.exe -crop 100%%x50%% %1 "%drive%%dir_path%%file_name%-%%d%ext_name%"
