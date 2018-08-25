Menu, Tray, Icon, e.ico

#e::
	t := Clipboardall
	Clipboard := ""
	Send, ^c
	ClipWait, 0.5
	if(Clipboard) {
		f := FileOpen("tmp.ahk", "w", "UTF-8")
		f.Write(Clipboard)
		f.Close()
		Run, % A_AHKPath " """ A_ScriptDir "\tmp.ahk""", , , pid
	}
	Clipboard := t
return

#w::
	DetectHiddenWindows On
	WinClose, % "ahk_pid " pid
return
