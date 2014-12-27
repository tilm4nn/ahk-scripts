;-------------------------------------------------------------------------
; Program start hotkeys
;-------------------------------------------------------------------------
F12 & a::Run, %ProgramFiles%\Sparx Systems\EA\EA.exe
F12 & c::Run, %ProgramFiles%\Cisco Systems\VPN Client\ipsecdialer.exe -c "DUKATH extern"
F12 & d::Run, %ProgramFiles%\SmartFTP\SmartFTP.exe
F12 & e::Run, %ProgramFiles%\eclipse\eclipse.exe -clean -vmargs -Xmx512M -Dosgi.splashLocation="C:\programme\ExadelStudio\splash.bmp"
F12 & f::Run, %ProgramFiles%\Mozilla Firefox\firefox.exe
F12 & g::Run, %ProgramFiles%\GMX\GMX Upload-Manager\GMXUploadManager.exe
F12 & i::Run, %ProgramFiles%\Miranda IM\miranda32.exe
F12 & l::Run, %ProgramFiles%\SSH Communications Security\SSH Secure Shell\SshClient.exe
F12 & m::
RunWait, G:\programme\MediaMonkey\MediaMonkey.exe
FileRemoveDir, C:\Dokumente und Einstellungen\tilmann\Eigene Dateien\Musik\MediaMonkey, 1
Return
F12 & q::Run, C:\Dokumente und Einstellungen\tilmann\Eigene Dateien\Eressea\magellan\magellan.bat
F12 & n::Run, %ProgramFiles%\NetBeans3.6\bin\runidew.exe
F12 & o::Run, %ProgramFiles%\Ulead Systems\Ulead Photo Explorer 8.0\pex.exe
F12 & p::Run, %ProgramFiles%\Ulead Systems\Ulead PhotoImpact XL\Iedit.exe
F12 & r::Run, %ProgramFiles%\14aRename\rename.exe
F12 & s::Run, %ProgramFiles%\Skype\Phone\Skype.exe
F12 & t::Run, %ProgramFiles%\Mozilla Thunderbird\thunderbird.exe
F12 & v::Run, %ProgramFiles%\VU\vuBrief\vu_Brief.exe
F12 & w::Run, %ProgramFiles%\Winamp5\Winamp.exe 
F12 & x::Run, explorer.exe /n`,/e`,c:\