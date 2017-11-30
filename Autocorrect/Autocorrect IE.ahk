
Menu, tray, Icon, Google.ico

#Include Util.ahk

IE := ComObjCreate("InternetExplorer.Application")

OnExit("KillIE")

#c::
	clipback := ClipboardAll
	Clipboard := ""
	Send ^c
	ClipWait, 0
	
	IE.Navigate("https://www.google.com/search?q=" Clipboard)
	
	While, IE.ReadyState  != 4 ; Wait for page to load
		Continue
		
	res := RegExReplace(IE.document.getElementsByClassName("spell")[1].innerHTML, "</?(b|i)>")
	
	Clipboard := res = "" ? Clipboard : Util_ReplaceHtmlEntities(res)
	Send ^v
	Sleep 500
	Clipboard := clipback
return

KillIE(){
	Global IE
	IE.Quit()
}
