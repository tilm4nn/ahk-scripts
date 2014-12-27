;-------------------------------------------------------------------------
; Miranda ShortCuts
;-------------------------------------------------------------------------
!Space::
{
  SetTitleMatchMode, 3
  DetectHiddenWindows, Off
  IfWinExist, ahk_class #32770
  {
    WinGetTitle, MIR_Title
    IfNotInString MIR_Title, Mail
      IfWinNotActive
      {
        ShowBuddyList()
        DetectHiddenWindows, Off
        WinActivate, ahk_class #32770  
      }
      else
      {
        WinMinimize
        ; SendInput, !{Tab}
        HideBuddyList()
      }
  }
  else
  {
    ToggleBuddyList()
  }
  return
}

!Enter::
{
  SetTitleMatchMode, 3
  IfWinActive, ahk_class #32770
  {
    WinGetTitle, MIR_Title
    IfNotInString MIR_Title, Mail
    {
      SendInput, !s
      WinMinimize
      ; SendInput, !{Tab}
      HideBuddyList() 
    }
  }
  return
}

!Backspace::
{
  IfWinActive, ahk_class #32770
  {
    WinGetTitle, MIR_Title
    IfNotInString MIR_Title, Mail
    {
      HideBuddyList()
    }
  }
  WinClose, A
}

ToggleBuddyList()
{
  SetTitleMatchMode, 3
  DetectHiddenWindows, On
  IfWinActive, Miranda
  {
    SendInput, !{Tab}
    HideBuddyList()
  }
  Else
  {
    ShowBuddyList()
  }
  return
}

HideBuddyList()
{
  IfWinExist, Miranda
  {
    WinHide
  }
}

ShowBuddyList()
{
  DetectHiddenWindows, Off
  IfWinExist, Miranda
  {
    WinActivate
  }
  Else
  {
    DetectHiddenWindows, On
    IfWinExist, Miranda
    {
      WinShow
      WinActivate
    }
  }
}
