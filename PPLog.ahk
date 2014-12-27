;-----------------------------------------------------------------------------
;
;    PPLog ShortCuts for Windows v0.9
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
;    distributed under GPL or you can use the compiled version of the script
;    provided in pplog_shortcuts.exe
;
; o  Please feel free to send bug reports and feature requests to
;    pplog@tkuhn.de
;
; o  The Script activates several keyboard shortcuts that help writing pplog-
;    files on windows machines. It works with text editors that show filenames
;    in their titles. This is done by looking for windows titles that contain
;    the string ".ppl". So it is not a good idea to open multiple windows that
;    match the cirterea since this may lead to unpredictable results. The
;    scipt has been tested wiht notepad but other editors might work as well.
;    b/e detection doesn't work in wordpad at this time. :-(
;    The provided shortcuts are:
;
;    Control-F8: (Insert Timestamp)
;    Switch to open .ppl window, move to the end of the file, enter timestamp
;    followed by a space
;
;    Control-F9: (Insert Timestamp and Interrupt)
;    Switch to open .ppl window, move to the end of the file, enter timestamp
;    followed by a space, examine the contents of the file and either enter
;    "bi" or "ei" whichever seems appropriate.
;
;    Control-F10: (Insert Timestamp and Error)
;    Switch to open .ppl window, move to the end of the file, enter timestamp
;    followed by a space, examine the contents of the file and either enter
;    "be" or "ee" whichever seems appropriate.
;
;    Control-Enter: (Go back to last application)
;    If the active window is a .ppl window, activate the last application in
;    use before working on the pplog.
;    
;-----------------------------------------------------------------------------

/* Send the timestamp and a space 
 */
SendTimeStamp()
{
  FormatTime time, , yyyy-MM-dd HH:mm:ss
  Send, %time%%A_Space%
  return
}

/* Activate a window with .ppl in its title
 */
ActivateEndOfPpl()
{
  SetTitleMatchMode, 2
  IfWinExist, .ppl
  {
    WinActivate
    Send ^{End}{Enter}
    return true
  }
  MsgBox Could not find any editor with open *.ppl file!
  return false
}

/* Test if the log in the current window is inside the given
 * region.
 */
Inside(region)
{
  WinGetText, text, A
  searchText = b%region%
  StringGetPos, lastBegin, text, %A_Space%%searchText%, R
  searchText = e%region%
  StringGetPos, lastEnd, text, %A_Space%%searchText%, R
  ; SendRaw, %text%
  ; Send, %lastBegin% %lastEnd%
  if (lastBegin > lastEnd)
  {
    return true
  }
  return false
}

/* Send either a begin for the region or an end, wichever is
 * appropriate.
 */
SendDelimiter(region)
{
  SendTimeStamp()
  if (Inside(region))
  {
     Send, e%region%
  }
  else
  {
    Send, b%region%
  }
  return
}

/* On Crtl-F8 Switch to the Window and enter the timestamp 
 */
^F8::
{
  if (ActivateEndOfPpl())
  {
    SendTimeStamp()
  }
  return
}

/* On Crtl-F9 Switch to the Window and enter the timestamp
 * and begin or end an interruption 
 */
^F9::
{
  if (ActivateEndOfPpl())
  {
    SendDelimiter("i")
  }
  return
}

/* On Alt-F10 Switch to the Window and enter the timestamp
 * and begin or end an error
 */
^F10::
{
  if (ActivateEndOfPpl())
  {
    SendDelimiter("e")
  }
  return
}

/* On Crtl-Enter return to the last application that was in use
 */
$^Enter::
{
  SetTitleMatchMode, 2
  IfWinNotActive, .ppl
  {
    Send, ^{Enter}
    return
  }
  Send, !{Tab}
  return
}