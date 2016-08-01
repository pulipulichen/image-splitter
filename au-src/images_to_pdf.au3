$files = ""

For $i = 1 To $CmdLine[0]
    IF FileExists($CmdLine[$i]) and StringInStr(FileGetAttrib($CmdLine[$i]),"D") Then
        RunWait('dir_to_pdf.exe "' & $CmdLine[$i] & '"')
    Else
        $files = $files & '"' & $CmdLine[$i] & '" '
    EndIf
Next

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

$dir_path = GetDir($CmdLine[1])
$dir_name = GetFileName(GetDir($CmdLine[1]))

;#include <MsgBoxConstants.au3>
;MsgBox($MB_SYSTEMMODAL, $dir_name, 'image_magick\convert.exe ' & $files & $dir_path & "\" &  $dir_name & '.pdf', 10)

RunWait('image_magick\convert.exe ' & $files & '"' & $dir_path & "\" &  $dir_name & '.pdf"', @ScriptDir, @SW_HIDE)

$delete_after_converting = IniRead ( "config.ini", "config", "delete_after_converting", "1" )

If $delete_after_converting = "1" Then
   For $i = 1 To $CmdLine[0]
        IF FileExists($CmdLine[$i]) and StringInStr(FileGetAttrib($CmdLine[$i]),"D") = 0 Then
            FileRecycle($CmdLine[$i])
        EndIf
   Next
EndIf
