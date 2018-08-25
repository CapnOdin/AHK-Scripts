Menu, Tray, Icon, js.ico
Gui, Add, ActiveX, vpwb, Shell.Explorer
pwb.Navigate("about:<!DOCTYPE HTML><head><meta http-equiv=""X-UA-Compatible"" content=""IE=Edge""><script>window.onerror = function(message, url, lineNumber) {return true;};var mod = function(x, n){return ((x%n)+n)%n;};</script></head>")

#x::
    t := Clipboardall
    Clipboard := ""
    Send, ^c
    ClipWait, 0.5
    
    if(Clipboard == "") {
        Send, +{Home 2}
        Send, ^c
        ClipWait, 0.5
    }
    
    if(StrLen(res := Eval(Clipboard))) {
        Clipboard .= " = " res
        Send, ^v
    }
    
    Clipboard := t
return

Eval(exp) {
    Global pwb
    try {
        exp := regExReplace(exp, "i)\bStrLoop\((\d+)\)", "res = """"; for(i = 0; i < $1; i++)")
    
        exp := regExReplace(exp, "i)\b(E|LN2|LN10|LOG2E|LOG10E|PI|SQRT1_2|SQRT2)\b", "$U1")
        exp := regExReplace(exp, "i)(?<!Math\.)\b(abs|acos|asin|atan|atan2|ceil|cos|exp|floor|log|max|min|pow|random|round|sin|sqrt|tan)\(", "Math.$1(")
        exp := regExReplace(exp, "i)(?<!Math\.)\b(E|LN2|LN10|LOG2E|LOG10E|PI|SQRT1_2|SQRT2)\b", "Math.$1")
        exp := regExReplace(exp, "i)\brng\b", "Math.random()")
        return pwb.Document.parentWindow.eval("try {" exp "} catch (e) { }")
    }
}