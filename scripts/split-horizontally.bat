SET drive=%~d1
SET dir_path=%~p1
SET file_name=%~n1
SET ext_name=%~x1
image_magick\convert.exe -crop 50%%x100%% %1 "%drive%%dir_path%%file_name%-%%d%ext_name%"

IF %2 == "0" (
    ECHO "OK"
    REN "%drive%%dir_path%%file_name%-0%ext_name%" "%file_name%-b%ext_name%"
    REN "%drive%%dir_path%%file_name%-1%ext_name%" "%file_name%-a%ext_name%"
)
