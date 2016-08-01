$page_is_left_to_right = IniRead ( "config.ini", "config", "page_is_left_to_right", "0" )

IF FileExists($CmdLine[1]) and StringInStr(FileGetAttrib($CmdLine[1]),"D") Then
   Exit
EndIf

$delete_after_converting = IniRead ( "config.ini", "config", "delete_after_converting", "1" )

For $i = 1 To $CmdLine[0]
    RunWait('scripts\split-horizontally.bat "' & $CmdLine[$i] & '" "' & $page_is_left_to_right & '"', @ScriptDir, @SW_HIDE)
    If $delete_after_converting = "1" Then
        FileRecycle($CmdLine[$i])
    EndIf
Next