;Scrolllock::
;{
;  GetKeyState, scroll, Scrolllock, T
;  if scroll = U 
;  {
;    SetScrollLockState, On
;    SendSpace()
;  }
;  else
;  {
;    SetScrollLockState, Off
;  }
;}

SendSpace()
{
  Sleep 1000
  waitTime = 15
  Loop
  {
    SendInput {Space}
    Sleep, %waitTime%
    GetKeyState, scroll, Scrolllock, P
    if scroll = D
    {
      SetScrollLockState, Off
      Sleep 1000
      break
    }
  }
}

SendAlphabet()
{
  waitTime = 120
  alphabet = a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z
  Loop
  {
    Loop, parse, alphabet, `,
    {
      SendInput %A_LoopField%
      Sleep, %waitTime%
      GetKeyState, scroll, Scrolllock, P
      if scroll = D
      {
        SetScrollLockState, Off
        Sleep 1000
        exit = true
        break
      }
    }
    if exit = true
      break
  }
}