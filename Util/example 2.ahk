#Persistent

#Include ApplicationWait.ahk

Class ApplicationModalFocus extends ApplicationWaitModalActive {
	first := True
	
	TimerFunc() {
		hwnd := this.GetHwnd(), active := WinActive("A")
		if(this.Check(hwnd, active)) {
			if(!this.condition || this.condition.Call(hwnd, active)) {
				this.Success()
				this.first := False
			} else {
				this.first := True
			}
		} else {
			this.first := True
		}
	}

	Success() {
		if(this.first) {
			this.callback.Call()
		}
	}
}

timer := new ApplicationFocus("ahk_class Notepad ahk_exe notepad.exe", Func("Search"), , Func("TitleIs").Bind("Find"))

TitleIs(title, hwnd, active) {
	WinGetTitle, activetitle, % "ahk_id " active
	return activetitle = title
}

Search() {
	Send, ahk
}



#SingleInstance, force

SendMode, Input

LButton::
    Send, {LButton Down}
Return

LButton Up::
    Send, {RButton Down}
    Sleep, 100
    Send, {LButton Up}
    Sleep, 100
    Send, {RButton Up}
Return

