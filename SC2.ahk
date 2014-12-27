
InjectLarva()
{
   MouseGetPos xpos, ypos 
   MouseMove A_ScreenWidth/2, A_ScreenHeight/2-30
   SendInput 4
   SendInput x
   SendInput {Backspace}
   Sleep 50
   Click 
   SendInput {Esc}
   MouseMove xpos, ypos
   return
}


LWin::
{
  InjectLarva()
}
