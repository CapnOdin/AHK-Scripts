
Menu, tray, Icon, Google.ico

#Include StdOutToVar.ahk
#Include Util.ahk

danish := {"µ" : "æ", "°" : "ø", "Õ" : "å"}

#c::
	clipback := ClipboardAll
	Clipboard := ""
	Send ^c
	ClipWait, 0
	
	res := Util_ReplaceHtmlEntities(StdOutStream("python GoogleSearch.py " """" Clipboard """"))
	
	for key, val in danish {
		res := StrReplace(res, key, val)
	}
	
	Clipboard := res
	
	Send ^v
	Sleep 500
	Clipboard := clipback
return
