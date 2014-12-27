;-------------------------------------------------------------------------
; Start skript to set locale to german
;-------------------------------------------------------------------------
;ListLines  ; Show the script's main window.
;WinWaitActive ahk_class AutoHotkey
;Send {LAlt down}{Shift}{LAlt up}  ; Switch languages (keys must be in this format).
;Sleep 100  ; Give it time to take effect (might not be necessary).
;WinMinimize  ; Uses the window found above.

;-------------------------------------------------------------------------
; Hotstrings for programming
;-------------------------------------------------------------------------
#Hotstring c ; Case sensitive
#Hotstring EndChars  .(
:R:pu::public
:R:st::static
:R:pr::private
:R:fi::final
:R:str::string
:R :Str::String
:R  :STr::String
:R:bo::boolean
:R:re::return
:R:imp::implements
:R:sout::System.out.println