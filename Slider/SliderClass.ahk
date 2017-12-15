
Class Slider {
	
	__New(Gui := 1, guiOptions := "", Min := 0, Max := 100, StartValues := False, Connections := False, CallBack := False) {
		if(!(guiOptions ~= "w\d+")) {
			guiOptions .= " w500"
		}
		if(!(guiOptions ~= "h\d+")) {
			guiOptions .= " h35"
		}
		Gui, %Gui%:Add, ActiveX, % guiOptions " +HwndHwnd", Shell.Explorer
		GuiControlGet, IE, , % Hwnd
		this.IE := IE
		this.CallBack := CallBack
		this.Navigate()
		this.AddToGUI(Min, Max, StartValues, Connections)
	}
	
	AddToGUI(Min, Max, StartValues, Connections) {
		
		this.Count := 0
		
		this.IE.Document.body.style.overflow := "hidden"
		
		Segments := this.GetSegments(StartValues, Min, Max)
		Connections := this.GetConnections(Connections)
		
		this.IE.Document.parentWindow.ahk_func := ObjBindMethod(this, "OnChange")
		
		this.IE.Document.parentWindow.eval("var mys = new Slider({'min': [" Min "],'max': [" Max "]}, [" Segments "], [" Connections "]);")
		;this.IE.Document.parentWindow.eval("var mys = new Slider2();")
		this.SetColour(0xF0F0F0)
	}
	
	SetColour(Background := False, Segments := False) {
		if(Background) {
			this.IE.Document.body.style.background := Format("#{:06X}", Background)
		}
		if(Segments) {
			connections := this.IE.Document.parentWindow.eval("mys.connect;")
			if(IsObject(Segments)) {
				loop % connections.length {
					if(A_Index <= Segments.Length()) {
						connections[A_Index-1].style.background := Format("#{:06X}", Segments[A_Index])
					}
				}
			} else {
				loop % connections.length {
					connections[A_Index-1].style.background := Format("#{:06X}", Segments)
				}
			}
		}
	}
	
	OnChange(values) {
		loop % values.length {
			if(this.Values[A_Index-1] != values[A_Index-1]) {
				this.Change := A_Index-1
				Break
			}
		}
		this.Values := values
		if(this.CallBack) {
			this.CallBack(this)
		}
	}
	
	Navigate() {
		this.IE.Navigate(A_ScriptDir "\slider.html")
		
		While this.IE.ReadyState != 4 || this.IE.Busy {
			Sleep, 20
		}
	}
	
	GetConnections(Connections) {
		if(IsObject(Connections)) {
			for i, b in Connections {
				res .= (b ? "true" : "false") ", "
			}
			return SubStr(res, 1, -2)
		}
		res := "true, "
		loop % this.Count {
			res .= "true, "
		}
		return SubStr(res, 1, -2)
	}

	GetSegments(values, min, max) {
		if(IsObject(values)) {
			this.Count := values.Length()
			return this.StrJoin(values, ", ")
		}
		if(values && this.IsNum(values)) {
			this.Count := values
			fraction := (max - min) / (values + 1)
			loop % values {
				res .= min + fraction * A_Index ", "
			}
			return SubStr(res, 1, -2)
		}
		this.Count := 1
		return (max - min) / 2 + min
	}

	StrJoin(lst, sep) {
		for i, str in lst {
			res .= str sep
		}
		return SubStr(res, 1, - StrLen(sep))
	}

	IsNum(num) {
		if num is number
			return True
		return False
	}
}
