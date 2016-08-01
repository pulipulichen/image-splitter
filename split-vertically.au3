IF FileExists($CmdLine[0]) and StringInStr(FileGetAttrib($CmdLine[0]),"D") Then
   Exit
EndIf

For $i = 1 To $CmdLine[0]
		RunWait('split-vertically.bat "' & $CmdLine[$i] & '"', @ScriptDir, @SW_HIDE)
Next

$delete_after_converting = IniRead ( "config.ini", "config", "delete_after_converting", "1" )

If $delete_after_converting = "1" Then
   For $i = 1 To $CmdLine[0]
	  FileRecycle($CmdLine[$i])
   Next
EndIf
