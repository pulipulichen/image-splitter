#include <Array.au3>
#include <File.au3>

$delete_after_converting = IniRead ( @ScriptDir & "\config.ini", "config", "delete_after_converting", "1" )

For $i = 1 To $CmdLine[0]
    IF FileExists($CmdLine[$i]) and StringInStr(FileGetAttrib($CmdLine[$i]),"D") Then
        $filesList = _FileListToArray($CmdLine[$i])
        For $j = 1 To $filesList[0]
            RunWait('split-vertically.exe "' & $CmdLine[$i] & '\' & $filesList[$j] & '"', @ScriptDir, @SW_HIDE)
        Next
    Else
        RunWait('scripts\split-vertically.bat "' & $CmdLine[$i] & '"', @ScriptDir, @SW_HIDE)

        If $delete_after_converting = "1" Then
            FileRecycle($CmdLine[$i])
        EndIf
    EndIf
Next




