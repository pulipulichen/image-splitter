SET drive=%~d1
SET dir_path=%~p1
SET file_name=%~n1
SET ext_name=%~x1

image_magick\convert.exe -crop 100%%x50%% %1 "%drive%%dir_path%%file_name%-%%d%ext_name%"
