
#Include %A_LineFile%\..\Is.ahk

ApplicationWait_Active(hwnd, CallBack) {
	ApplicationWait_Init(hwnd, active)
	if(active = hwnd || ApplicationWait_GetAncestor(active) = hwnd) {
		ApplicationWait_Success(CallBack)
	}
}

ApplicationWait_NotActive(hwnd, CallBack) {
	ApplicationWait_Init(hwnd, active)
	if(active != hwnd && ApplicationWait_GetAncestor(active) != hwnd && active != 0x0) {
		ApplicationWait_Success(CallBack)
	}
}

ApplicationWait_ModalActive(hwnd, CallBack) {
	ApplicationWait_Init(hwnd, active)
	if(ApplicationWait_GetAncestor(active) = hwnd) {
		ApplicationWait_Success(CallBack)
	}
}

ApplicationWait_ModalNotActive(hwnd, CallBack) {
	ApplicationWait_Init(hwnd, active)
	if(active = hwnd || ApplicationWait_GetAncestor(active) != hwnd) {
		ApplicationWait_Success(CallBack)
	}
}

ApplicationWait_Init(ByRef hwnd, ByRef active) {
	active := WinActive("A")
	hwnd := ApplicationWait_TitleToHwnd(hwnd)
}

ApplicationWait_Success(CallBack) {
	SetTimer, , Off
	CallBack.Call()
}

ApplicationWait_GetAncestor(hwnd) {
	return DllCall("GetAncestor", "Ptr", hwnd, "UInt", 3)
}

ApplicationWait_TitleToHwnd(title) {
	if(!Is_OfType(title, "xdigit")) {
		WinGet, hwnd, Id, % title
		return hwnd
	}
	return title
}
