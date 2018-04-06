
ApplicationWait_Active(hwnd, CallBack) {
	active := WinActive("A")
	if(active = hwnd || __GetParent(active) = hwnd) {
		ApplicationWaitSuccess(CallBack)
	}
}

ApplicationWait_NotActive(hwnd, CallBack) {
	active := WinActive("A")
	if(active != hwnd && __GetParent(active) != hwnd) {
		ApplicationWaitSuccess(CallBack)
	}
}

ApplicationWait_ModalActive(hwnd, CallBack) {
	active := WinActive("A")
	if(__GetParent(active) = hwnd) {
		ApplicationWaitSuccess(CallBack)
	}
}

ApplicationWait_ModalNotActive(hwnd, CallBack) {
	active := WinActive("A")
	if(active = hwnd || __GetParent(active) != hwnd) {
		ApplicationWaitSuccess(CallBack)
	}
}

ApplicationWait_Success(CallBack) {
	SetTimer, , Off
	CallBack.Call()
}

__GetParent(hwnd) {
	return DllCall("GetParent", "Ptr", hwnd)
}
