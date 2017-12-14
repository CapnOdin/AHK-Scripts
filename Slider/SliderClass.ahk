
SetBatchLines -1

GuiName := "AHK"

Gui, %GuiName%:New, +Resize, Slider
Gui, Margin, 0, 0
ID1 := New Slider(GuiName, "w500 h40", 0, 100, [25, 50, 75], [False, True, True, False])
ID2 := New Slider(GuiName, "w500 h40", 0, 100, 5)
ID3 := New Slider(GuiName, "w500 h40", 0, 100)
Gui, Show, AutoSize
return

AHKGuiClose(GuiHwnd) {
	ExitApp
}

Class Slider {
	
	Static ID := 0
	
	__New(Gui, guiOptions, Min, Max, StartValues := False, Connections := False) {
		Static
		Slider.ID++
		Gui, %Gui%:Add, ActiveX, % guiOptions " vIE" Slider.ID, Shell.Explorer
		__var__ := "IE" Slider.ID
		this.IE := %__var__%
		this.Navigate()
		this.AddToGUI(Min, Max, StartValues, Connections)
	}
	
	AddToGUI(Min, Max, StartValues, Connections) {
		
		this.Count := 0
		
		this.IE.Document.body.style.overflow := "hidden"
		this.IE.Document.body.style.backgroundColor := "#F0F0F0"
		
		Segments := this.GetSegments(StartValues, Min, Max)
		Connections := this.GetConnections(Connections)
		
		strID := "ahk_func" Slider.ID
		
		this.IE.Document.parentWindow.ahk_func := ObjBindMethod(this, "GetVal") ;Func("GetValues").Bind(this)
		
		this.IE.Document.parentWindow.eval("var mys = new Slider({'min': [" Min "],'max': [" Max "]}, [" Segments "], [" Connections "]);")
	}
	
	GetVal(values) {
		loop % values.length {
			if(this.Values[A_Index-1] != values[A_Index-1]) {
				ToolTip, % values[A_Index-1]
			}
		}
		this.Values := values
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
