;-----------------------------------------------------------------------------
;
;    Rectangular Edit for Windows v0.9
; 
;    Copyright (C) 2014   Tilmann Kuhn   http://www.tkuhn.de
;
; o  The MIT License
;    
;    Permission is hereby granted, free of charge, to any person obtaining a copy
;    of this software and associated documentation files (the "Software"), to deal
;    in the Software without restriction, including without limitation the rights
;    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
;    copies of the Software, and to permit persons to whom the Software is
;    furnished to do so, subject to the following conditions:
;    
;    The above copyright notice and this permission notice shall be included in
;    all copies or substantial portions of the Software.
;    
;    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
;    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
;    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
;    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
;    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
;    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
;    THE SOFTWARE.
;
; o  To use this script you will either need
;    AutoHotkey (http://www.autohotkey.com) by Chris Mallett which is also
;    distributed under GPL or you can use the compiled version of the script.
;    
;-----------------------------------------------------------------------------


/*
Rectangular Paste:
Ermittle b = position in 1. Zeile
Ermittle e = position in letzter Zeile
wenn b <= e:
  für alle zeilen:
    ersetzte text zwischen b und e mit inhalt der zwischenablage


Rectangular Delete:
Ermittle b = position in 1. Zeile
Ermittle e = bosition in letzter Zeile
wenn b < e:
  für alle zeilen:
    lösche text zwischen b und e


Rectangular Copy:
Ermittle b = position in 1. Zeile
Ermittle e = bosition in letzter Zeile
wenn b < e:
  für alle zeilen:
    kopiere text zwischen b und e


Rectangular Cut:
Ermittle b = position in 1. Zeile
Ermittle e = bosition in letzter Zeile
wenn b < e:
  für alle zeilen:
    kopiere text zwischen b und e
*/


^+C::Copy()
^+V::Paste()
^+X::Cut()
^+Del::Delete()

Paste()
{
  oCB := ClipBoardAll
  pasteText := ClipBoard
  RetrieveValues(text, begin, length)
  out := ""
  copy := ""
  ProcessText(text, begin, length, pasteText, false, copy, out)
  OutputResult(out)
  ClipBoard := oCB
  oCB = 
  out =
  copy =
  text =
  pasteText =
}

Copy()
{
  RetrieveValues(text, begin, length)
  out := ""
  copy := ""
  ProcessText(text, begin, length, "", false, copy, out)
  OutputResult(out)
  ClipBoard := copy
  out =
  copy =
  text =
}

Cut()
{
  RetrieveValues(text, begin, length)
  out := ""
  copy := ""
  ProcessText(text, begin, length, "", true, copy, out)
  OutputResult(out)
  ClipBoard := copy
  out =
  copy =
  text =
}

Delete()
{
  oCB := ClipBoardAll
  RetrieveValues(text, begin, length)
  out := ""
  copy := ""
  ProcessText(text, begin, length, "", true, copy, out)
  OutputResult(out)
  ClipBoard := oCB
  oCB = 
  out =
  copy =
  text =
}

OutputResult(out)
{
  ClipBoard := out
  SendInput ^v
  Sleep, 50
}


RetrieveValues(ByRef inputText, ByRef begin, ByRef length)
{
  Clipboard := ""
  SendInput ^x
  Sleep, 50
  tail := clipboard
  SendInput +{Home}
  Sleep, 50
  Clipboard := ""
  SendInput ^x
  Sleep, 50
  head := clipboard
  inputText := head . tail
  ; MsgBox, Head:`n%head%`nTail:`n%tail%`nInputText:`n%inputText%
  begin := StrLen(head) + 1
  newlinepos := InStr(tail, "`n", true, 0)
  if (newlinepos <= 0)
  {
    length := StrLen(tail)
  }
  else
  {
    length := StrLen(tail) - newlinepos - begin + 1
  }
}

ProcessText(inputText, begin, length, pasteText, delete, ByRef copy, ByRef out)
{
  ; MsgBox, InputText:`n%inputText%`nBegin:%begin%`nLength:%length%`nPasteText:`n%pasteText%`nDelete:%delete%
  pasteArray0 := 0
  pasteLine := ""
  if (pasteText)
  {
    if (InStr(pasteText, "`n"))
    {
      StringSplit, pasteArray, pasteText, `n, `r
    }
    else
    {
      pasteLine := pasteText
    }
  }
  firstRun := true
  Loop, parse, inputText, `n, `r
  {
    if (firstRun)
    {
      firstRun := false
    }
    else
    {
      out .= "`r`n"
      copy .= "`r`n"
    }    
    if (pasteArray0)
    {
      if (A_Index <= pasteArray0)
      {
        pasteLine := pasteArray%A_Index%
      }
      else
      {
        pasteLine := ""
      }
    }
    ProcessLine(A_LoopField, begin, length, pasteLine, delete, copy, out)
    ; MsgBox, Out:`n%out%
  }
}

ProcessLine(inputLine, begin, length, pasteLine, delete, ByRef copy, ByRef out)
{
  ; MsgBox, Input:%inputLine%`nBegin:%begin%`nLength:%length%`nPasteLine:%pasteLine%`nDelete:%delete%
  if (length > 0 or pasteLine)
  {
    if (length > 0)
    {
      copy .= SubStr(inputLine, begin, length)
    }
    if (delete or pasteLine)
    {
      if (begin > 1)
      {
        out .= SubStr(inputLine, 1, begin - 1)
      }
      if (pasteLine)
      {
        out .= pasteLine
      }
      tailStart := begin + length
      tailLength := StrLen(inputLine) - tailStart + 1
      if (tailLength > 0)
      {
        out .= SubStr(inputLine, tailStart, tailLength)
      }
    }
    else
    {
      out .= inputLine
    }
  }
  else
  {
    out .= inputLine
  }
}