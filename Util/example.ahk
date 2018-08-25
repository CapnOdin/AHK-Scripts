
#Persistent

#Include ApplicationWait.ahk

timer := new ApplicationWaitModalActive("ahk_class Notepad ahk_exe notepad.exe", Func("Search"), , Func("TitleIs").Bind("Find"))

TitleIs(title, hwnd, active) {
	WinGetTitle, activetitle, % "ahk_id " active
	return activetitle = title
}

Search() {
	Send, ahk{Enter}
}



;$q::timer := new ApplicationWaitActive("ahk_class Notepad ahk_exe notepad.exe", Func("beep"), 20)

;$w::timer := new ApplicationWaitNotActive("ahk_class Notepad ahk_exe notepad.exe", Func("beep"), 20)

;$e::timer := new ApplicationWaitModalActive("ahk_class Notepad ahk_exe notepad.exe", Func("beep"), 20)

;$r::timer := new ApplicationWaitModalNotActive("ahk_class Notepad ahk_exe notepad.exe", Func("beep"), 20)

;$a::timer.On(True)

;$s::timer.On(False)

;$d::timer.Destroy()

beep() {
	SoundBeep 3000
}


