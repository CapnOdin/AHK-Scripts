
Menu, tray, Icon, Google.ico

WebRequest := ComObjCreate("WinHttp.WinHttpRequest.5.1")

#c::
	clipback := ClipboardAll
	clipboard := ""
	Send ^c
	ClipWait, 0
	
	WebRequest.Open("GET", "https://www.google.com/search?q=" . clipboard, True)
	
	WebRequest.Option[6] := True
	
	WebRequest.SetRequestHeader("Accept", "*/*")
	WebRequest.SetRequestHeader("Accept-Encoding", "UTF-8")
	WebRequest.SetRequestHeader("Accept-Language", "en,da;q=0.7,en-US;q=0.3")
	WebRequest.SetRequestHeader("Connection", "keep-alive")
	WebRequest.SetRequestHeader("DNT", "1")
	WebRequest.SetRequestHeader("Referer", "https://www.google.com")
	WebRequest.SetRequestHeader("User-Agent", "Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:45.0) Gecko/20100101 Firefox/45.0")
	
	WebRequest.Send()
	WebRequest.WaitForResponse()
	MsgBox, % WebRequest.GetAllResponseHeaders()
	contents := WebRequest.ResponseText
	;MsgBox, % InStr(contents, "Mente du:")
	;MsgBox, % SubStr(contents, InStr(contents, "Mente du:"))
	
	f := FileOpen("file.htm", "w")
	f.Write(contents)
	
	if(RegExMatch(contents, "(Showing results for|Did you mean:|Mente du:)</span>.*?>(.*?)</a>", match)) {
		StringReplace, clipboard, match2, <b><i>,, All
		StringReplace, clipboard, clipboard, </i></b>,, All
		clipboard := RegExReplace(clipboard, "&#39;", "'")
		clipboard := RegExReplace(clipboard, "&amp;", "&")
	}
	Send ^v
	Sleep 500
	clipboard := clipback
return
