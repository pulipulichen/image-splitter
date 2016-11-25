#include <Array.au3>
#include <File.au3>

$delete_after_converting = IniRead ( @ScriptDir & "\config.ini", "config", "delete_after_converting", "1" )

$files = ""

For $i = 1 To $CmdLine[0]
    IF FileExists($CmdLine[$i]) and StringInStr(FileGetAttrib($CmdLine[$i]),"D") Then
        $filesList = _FileListToArray($CmdLine[$i])
        For $j = 1 To $filesList[0]
            $files = $files & '"' & $CmdLine[$i] & '\' & $filesList[$j] & '" '
        Next
        RunWait('append-vertically.exe ' & $files, @ScriptDir, @SW_HIDE)
        Exit
    Else
        $files = $files & '"' & $CmdLine[$i] & '" '
    EndIf
Next

MsgBox ( $MB_OK, "title", 'scripts\append-vertically.bat ' & $files)
Exit
RunWait('scripts\append-vertically.bat ' & $files, @ScriptDir, @SW_HIDE)

For $i = 1 To $CmdLine[0]
    IF FileExists($CmdLine[$i]) and StringInStr(FileGetAttrib($CmdLine[$i]),"D") Then

    Else
        If $delete_after_converting = "1" Then
            FileRecycle($CmdLine[$i])
        EndIf
    EndIf
Next


