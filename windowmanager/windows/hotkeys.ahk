#Requires AutoHotkey v2.0
#SingleInstance Force

Komorebic(cmd) {
    RunWait(format("komorebic.exe {}", cmd), , "Hide")
}


; hotkey = win + alt = #!
; additional hotkey = win + alt + shift = #!+


; #########
; # Focus #
; #########
;
; # window
; # hotkey + htns
#!h::Komorebic("focus left")
#!t::Komorebic("focus up")
#!n::Komorebic("focus down")
#!s::Komorebic("focus right")
;
; # workspace
; # hotkey + 1..9
#!1::Komorebic("focus-named-workspace 1file")
#!2::Komorebic("focus-named-workspace 2www")
#!3::Komorebic("focus-named-workspace 3office")
#!4::Komorebic("focus-named-workspace 4term")
#!5::Komorebic("focus-named-workspace 5code")
#!6::Komorebic("focus-named-workspace 6xtra")
#!7::Komorebic("focus-named-workspace 7chat")
#!8::Komorebic("focus-named-workspace 8email")
#!9::Komorebic("focus-named-workspace 9media")
;
; # monitor
; # hotkey + gcrl
#!g::Komorebic("focus-monitor left")
;
; # focus child window/container
; # --> n/a
; # focus parent container
; # --> n/a
;
; # toggle focus between tiling / floating
; # hotkey + shift + b

; ########
; # Move #
; ########
;
; # window/container inside workspace
; # hotkey + shift + htns
#!+h::Komorebic("move left")
#!+t::Komorebic("move up")
#!+n::Komorebic("move down")
#!+s::Komorebic("move right")
;
; # window/container to workspace
; # hotkey + shift + 1..9
#!+1::Komorebic("move-to-named-workspace 1file")
#!+2::Komorebic("move-to-named-workspace 2www")
#!+3::Komorebic("move-to-named-workspace 3office")
#!+4::Komorebic("move-to-named-workspace 4term")
#!+5::Komorebic("move-to-named-workspace 5code")
#!+6::Komorebic("move-to-named-workspace 6xtra")
#!+7::Komorebic("move-to-named-workspace 7chat")
#!+8::Komorebic("move-to-named-workspace 8email")
#!+9::Komorebic("move-to-named-workspace 9media")
;
; # workspace to monitor
; # hotkey + shift + gcl
#!+g::Komorebic("move-workspace-to-monitor")
;
; #########
; # Close #
; #########
;
; # hotkey + w
#!w::Komorebic("close")
;
; ########
; # Size #
; ########
;
; # width
; # hotkey + left/right, hotkey + []
#!Right::
#!]::Komorebic("resize-axis horizontal increase")
#!Left::
#![::Komorebic("resize-axis horizontal decrease")
; # height
; # hotkey + up/down, hotkey + {}
#!Up::
#!+]::Komorebic("resize-axis vertical increase")
#!Down::
#!+[::Komorebic("resize-axis vertical decrease")
; # balance
; # hotkey + =
;
; ##########
; # Layout #
; ##########
;
; # toggle float/tiling
; # hotkey + b
#!b::Komorebic("toggle-float")
;
; # toggle maximize
; # hotkey + m
#!m::Komorebic("toggle-maximize")
;
; # where to position next window
; # hotkey + v
;
; ##################
; # Window manager #
; ##################
;
; # restart
; # hotkey + f3
#!F3::{
  MsgBox("Restarting komorebi")
  Komorebic("stop")
  Komorebic("start")
  Reload
}
; # exit
; # hotkey + f4
#!F4::{
  Komorebic("stop")
  MsgBox("Komorebi stopped") 
}
;
; ########
; # Apps #
; ########
;
; # cycle apps
; # TODO: do
; # launch apps
; # TODO: do
;
; # terminal
; # hotkey + (shift +) enter
#!Enter::Run("WezTerm",,"Hide")
;
; # screenshot
; # . to clipboard
; # hotkey + y
#!y::Send '#+s'
; # . to editor
; # TODO:
;
; # various other apps under new namespace
; # hotkey + p
;
; ###################################
; # Non-window-management shortcuts #
; ###################################
;
; # lock the machine
; # hotkey + f5
#!F5::DllCall("LockWorkStation")
;
; # change keyboard layout (must be keys that are same on all layouts)
; # hotkey + f1 for dvorak, hotkey + f2 for us
#!F1::Send '!+1'  
#!F2::Send '!+2'
