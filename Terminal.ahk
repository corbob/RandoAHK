#NoEnv
Menu, Tray, Icon, imageres.dll, 102 ; this changes the tray icon to a Green Shield!
;Menu, Tray, Icon, C:\Program Files\PowerShell\6\pwsh.exe
#SingleInstance force ;only one instance of this script may run at a time!
#MaxHotkeysPerInterval 2000
#WinActivateForce ;https://autohotkey.com/docs/commands/_WinActivateForce.htm

SetTimer,UPDATEDSCRIPT,500 

Insert::
    If(WinActive("ahk_exe WindowsTerminal.exe")){
        WinMinimize
        return
    }
    If(WinExist("ahk_exe WindowsTerminal.exe")){
        WinActivate
        CenterWindow("ahk_exe WindowsTerminal.exe")
        return
    }
    Run, wt.exe
return

CenterWindow(WinTitle)
{
    WinGetPos,,, Width, Height, %WinTitle%
    WinMove, %WinTitle%,, (A_ScreenWidth/2)-(Width/2), (A_ScreenHeight/2)-(Height/2)
}

UPDATEDSCRIPT: 
	if(checkFileForChanges(A_ScriptFullPath))
		Reload 
Return 

checkFileForChanges(file) {
	FileGetAttrib,attribs,%file%
	IfInString,attribs,A 
	{ 
		ToolTip, Something changed in %file% ...,,,8
		sleep, 750
		tooltip, ,,,8
		FileSetAttrib,-A,%file% 
		return True
	}
    return False
}
