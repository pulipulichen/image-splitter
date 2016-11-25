#include <Array.au3>
#include <File.au3>

$page_is_left_to_right = IniRead ( @ScriptDir & "\config.ini", "config", "page_is_left_to_right", "1" )
$delete_after_converting = IniRead ( @ScriptDir & "\config.ini", "config", "delete_after_converting", "1" )

For $i = 1 To $CmdLine[0]
    IF FileExists($CmdLine[$i]) and StringInStr(FileGetAttrib($CmdLine[$i]),"D") Then
        $filesList = _FileListToArray($CmdLine[$i])
        For $j = 1 To $filesList[0]
            RunWait('split-horizontally.exe "' & $CmdLine[$i] & '\' & $filesList[$j] & '"', @ScriptDir, @SW_HIDE)
        Next
    Else
        RunWait('scripts\split-horizontally.bat "' & $CmdLine[$i] & '" "' & $page_is_left_to_right & '"', @ScriptDir, @SW_HIDE)

        If $delete_after_converting = "1" Then
            FileRecycle($CmdLine[$i])
        EndIf
    EndIf
Next