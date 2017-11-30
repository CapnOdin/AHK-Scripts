Menu, Tray, Icon, e.ico
#e::
	t := Clipboardall
	Clipboard := ""
	Send, ^c
	ClipWait, 0.5
	if(Clipboard) {
		f := FileOpen("tmp.ahk", "w")
		f.Write(Clipboard)
		f.Close()
		Run, % A_AHKPath " """ A_ScriptDir "\tmp.ahk"""
	}
	Clipboard := t
return
