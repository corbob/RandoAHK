#NoEnv
SendMode Input
Menu, Tray, Icon, imageres.dll, 101

#SingleInstance force ;only one instance of this script may run at a time!
#WinActivateForce ;https://autohotkey.com/docs/commands/_WinActivateForce.htm

SetTimer,UPDATEDSCRIPT,500 

UPDATEDSCRIPT: 
	if(checkFileForChanges(A_ScriptFullPath))
		Reload 
Return 

checkFileForChanges(file) {
	FileGetAttrib,attribs,%file%
	IfInString,attribs,A 
	{ 
		ToolTip, Something changed in %file% ...,,,8
		sleep, 1000
		tooltip, ,,,8
		FileSetAttrib,-A,%file% 
		return True
	}
	return False
}

; Disable CapsLock key.
*CapsLock::Return

; Win+s will ask for a hostname, then scan it's subnet for systems with port 5900 (VNC) accessible.
#s::
InputBox, system, Enter Hostname, Please enter the system to scan.
If (system == "") or (ErrorLevel) {

} Else {
    Run, cmd.exe /c title nmap: %system% & "C:\Program files (x86)\nmap\nmap.exe" -p 5900 --open %system%/24 | find "Nmap" & pause
}
Return

; Ctrl+Win+s will scan the subnet of a given host to find any that are responding to pings.
^#s::
InputBox, system, Enter Hostname, Please enter the system to scan.
If (system == "") or (ErrorLevel) {

} Else {
    Run, cmd.exe /c title nmap: %system% & "C:\Program files (x86)\nmap\nmap.exe" -sn %system%/24 | find "Nmap" & pause
}
Return

; Ctrl+Win+p ask for hostname, then set up a constant ping to port 5900 for that system. Useful when rebooting a system and needing to see when VNC comes back.
^#p::
InputBox, system, Enter system to ping, Please enter the system you would like to ping.
If (system == "") or (ErrorLevel) {

} Else {
    Run, cmd.exe /c title psping: %system% & c:\tools\sysinternals\psping.exe -t %system%:5900 & pause
}
Return

; Ctrl+Win+l lookup a system within lansweeper
^#l::
InputBox, system, Enter the system to lookup in LanSweeper, Please enter the system.
If (system == "") or (ErrorLevel) {

} Else {
    Run, https://lansweeper.example.com/quicksearch.aspx?q=%system%
}
Return

; Win+w DNS lookup a system.
#w::
InputBox, nslookup, Enter the system to lookup, Please enter the system you would like to lookup.
If (nslookup =="") Or (ErrorLevel) {

} Else {
    Run, cmd.exe /c nslookup %nslookup% & pause
}
Return

; These intercept numpad keys and turn numlock on before sending the proper number.
NumpadIns::
Send, {NumLock}0
Return
NumpadEnd::
Send, {NumLock}1
Return
NumpadDown::
Send, {NumLock}2
Return
NumpadPgDn::
Send, {NumLock}3
Return
NumpadLeft::
Send, {NumLock}4
Return
NumpadClear::
Send, {NumLock}5
Return
NumpadRight::
Send, {NumLock}6
Return
NumpadHome::
Send, {NumLock}7
Return
NumpadUp::
Send, {NumLock}8
Return
NumpadPgUp::
Send, {NumLock}9
Return

ssignature := "Signature here. `r`n for newlines."

; :*: indicates text expansion without having to hit space. This fires as soon as the second m is typed
:*:lmom::Left Message On Machine

::om::`r`n-----Original Message-----`r`n

:*:tsig::
	clipboard = %ssignature%
	Send, ^v
Return
