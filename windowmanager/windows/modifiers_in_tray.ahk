#Requires AutoHotkey v2.0
#SingleInstance Force

; Create a simple topmost GUI
modGui := Gui("+AlwaysOnTop -Caption +ToolWindow")
modGui.SetFont("s5", "Segoe UI Bold")
global modText := modGui.AddText("Center vmodText w10 h40", "None")
PositionGui()
modGui.Show()
; Update modifiers every 100ms
SetTimer(UpdateModifiers, 100)

UpdateModifiers() {
    ; mods := ""
    ; if GetKeyState("Shift", "P")
    ;     mods .= "S`n"
    ; if GetKeyState("Ctrl", "P")
    ;     mods .= "C`n"
    ; if GetKeyState("Alt", "P")
    ;     mods .= "A`n"
    ; if GetKeyState("LWin", "P") || GetKeyState("RWin", "P")
    ;     mods .= "W"
    ; modText.Text := mods ? mods : "-"
    s := GetKeyState("Shift", "P") ? "S" : ""
    c := GetKeyState("Ctrl", "P") ? "C" : ""
    a := GetKeyState("Alt", "P") ? "A" : ""
    w := (GetKeyState("LWin", "P") || GetKeyState("RWin", "P")) ? "W" : ""
    mods := c . "`n" . a . "`n" . w . "`n" . s
    modText.Text := mods 
}

PositionGui() {
    ; SM_CXSCREEN (0)  → primary screen width
    ; SM_CYSCREEN (1)  → primary screen height
    screenW := SysGet(0)
    screenH := SysGet(1)

    ; Offset values so the GUI isn't flush against the edge
    marginX := 10
    marginY := 8
    guiW    := 10   ; match your GUI width
    guiH    := 40   ; match your GUI height

    x := screenW - guiW - marginX
    y := screenH - guiH - marginY

    modGui.Show(Format("x{} y{}", x, y))
}
