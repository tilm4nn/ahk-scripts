;-------------------------------------------------------------------------
; Hotstrings toggle 
;-------------------------------------------------------------------------
^Tab::
{
  DetectHiddenWindows, On
  SetTitleMatchMode, 2
  IfWinExist, hotstrings.ahk - AutoHotkey
  {
    WinClose
  }
  else
  {
    Run, hotstrings.ahk
  }
  return
}