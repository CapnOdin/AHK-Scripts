#Include SliderClass.ahk

SetBatchLines -1

GuiName := "AHK"

Gui, %GuiName%:New, +Resize, Slider
Gui, Margin, 0, 0
Slider1 := New Slider(GuiName, "w250", 0, 100, [25, 50, 75], [False, True, True, False], Func("Display"))
Slider1 := New Slider(GuiName, "ys w250", , , 3, [False, True, True, False], Func("Display"))

Slider2 := New Slider(GuiName, "xs", 0, 100, 5, , Func("Display"))

Slider3 := New Slider(GuiName, , 0, 100, 4, [False, True, False, True, False], Func("Display"))
Slider3.SetColour(, 0x6F0050)

Slider4 := New Slider(GuiName, , 0, 100, , , Func("Display"))
Slider4.SetColour(0x6F0000, [0x6F0050, 0x6F0050])

Slider5 := New Slider(GuiName, , , , , , Func("Display"))
Slider5.SetColour(0x6F0050, 0x6F0000)

Gui, %GuiName%:Add, Text, vNum xs w50 x225 Center, 000
Gui, Show, AutoSize
return

Display(obj) {
	Global Num, GuiName
	GuiControl, %GuiName%:, Num, % obj.Values[obj.Change]
}

AHKGuiClose(GuiHwnd) {
	ExitApp
}
