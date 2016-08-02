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

        $dir_path = GetDir($CmdLine[$i])
        $dir_name = GetFileName($CmdLine[$i])

        For $j = 1 To $filesList[0]
            $dir_file = $CmdLine[$i] & '\' & $filesList[$j]
            IF FileExists($dir_file) and StringInStr(FileGetAttrib($dir_file),"D") Then
                $dir_file_name = GetFileName($dir_file)
                RunWait('images_to_pdf.exe "' & $dir_file & '"')
                ;MsgBox($MB_SYSTEMMODAL, $dir_file & ".pdf", $dir_path & "\" & $dir_name & "_" & $dir_file_name & ".pdf")
                ;Exit
                FileMove($dir_file & ".pdf", $dir_path & "\"  & $dir_name & "_" & $dir_file_name & ".pdf")
            ElseIf StringInStr($dir_file,".pdf") Then
                $dir_file_name = GetFileName($dir_file)
                FileMove($dir_file, $dir_path & "\"  & $dir_name & "_" & $dir_file_name)
            Else
                $files = $files & '"' & $dir_file & '" '
            EndIf
        Next

        ;#include <MsgBoxConstants.au3>
        ;MsgBox($MB_SYSTEMMODAL, $dir_name, 'image_magick\convert.exe ' & $files & $dir_path & "\" &  $dir_name & '.pdf')

        RunWait('image_magick\convert.exe ' & $files & '"' & $dir_path & "\" &  $dir_name & '.pdf"', @ScriptDir, @SW_HIDE)

	  
    Else
        $dir_path = GetDir($CmdLine[$i])
        $file_name = GetFileName($CmdLine[$i])
        MsgBox($MB_SYSTEMMODAL, $dir_path, 'image_magick\convert.exe "' & $CmdLine[$i] & '" "' & $dir_path & "\" &  $file_name & '.pdf"')
        RunWait('image_magick\convert.exe "' & $CmdLine[$i] & '" "' & $dir_path & "\" &  $file_name & '.pdf"', @ScriptDir, @SW_HIDE)
    EndIf

    If $delete_after_converting = "1" Then
        FileRecycle($CmdLine[$i])
    EndIf
Next
