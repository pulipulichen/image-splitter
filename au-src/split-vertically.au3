IF FileExists($CmdLine[1]) and StringInStr(FileGetAttrib($CmdLine[1]),"D") Then
   Exit
EndIf

$delete_after_converting = IniRead ( "config.ini", "config", "delete_after_converting", "1" )
For $i = 1 To $CmdLine[0]
    RunWait('scripts\split-vertically.bat "' & $CmdLine[$i] & '"', @ScriptDir, @SW_HIDE)
    If $delete_after_converting = "1" Then
        FileRecycle($CmdLine[$i])
    EndIf
Next




