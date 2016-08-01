#include <Array.au3>
#include <File.au3>

Func GetDir($sFilePath)
	If Not IsString($sFilePath) Then
		Return SetError(1, 0, -1)
	EndIf

	return StringRegExpReplace($sFilePath, "\\[^\\]*$", "")
 EndFunc

 Func GetFileName($sFilePath)
	If Not IsString($sFilePath) Then
		Return SetError(1, 0, -1)
	EndIf

	Local $FileName = StringRegExpReplace($sFilePath, "^.*\\", "")

	Return $FileName
 EndFunc

$delete_after_converting = IniRead ( "config.ini", "config", "delete_after_converting", "1" )

For $i = 1 To $CmdLine[0]
   IF FileExists($CmdLine[$i]) and StringInStr(FileGetAttrib($CmdLine[$i]),"D") Then
	  $filesList = _FileListToArray($CmdLine[$i])

	  $files = ""

	  For $j = 1 To $filesList[0]
		 $files = $files & '"' & $CmdLine[$i] & '\' & $filesList[$j] & '" '
	  Next


	  $dir_path = GetDir($CmdLine[$i])
	  $dir_name = GetFileName($CmdLine[$i])

	  ;#include <MsgBoxConstants.au3>
	  ;MsgBox($MB_SYSTEMMODAL, $dir_name, 'image_magick\convert.exe ' & $files & $dir_path & "\" &  $dir_name & '.pdf')

	  RunWait('image_magick\convert.exe ' & $files & '"' & $dir_path & "\" &  $dir_name & '.pdf"', @ScriptDir, @SW_HIDE)

	  If $delete_after_converting = "1" Then
		 FileRecycle($CmdLine[$i])
	  EndIf

   EndIf
Next
