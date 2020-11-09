#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance Force  ; When reloading the script, skips the dialog box and replaces the old instance automatically, which is similar in effect to the Reload command.

#Include %A_ScriptDir%\my_utils.ahk

; Codeshare.io is an impressive online code editor that enables you to collaborate with others in real-time, using only a share link.
; Unfortunately, Codeshare lacks one important feature: Running code. It does not have any interpreters/compilers, and only focuses on the code editing capability.
; This program adds this capability to Codeshare. Anytime you press the F10 key in Codeshare, this script collects your code and runs it in the Python interpreter on your system.
; Basically, this script acts as a bridge between the Codeshare interface (open in your web browser) and the Python interpreter installed on your computer.

; Set the tray icon's tooltip
Menu, Tray, Tip, Codeshare Plus

; Add a menu separator line and some menu items to the tray icon's context menu
Menu, Tray, Add
Menu, Tray, Add, Settings, settings
Menu, Tray, Add, Donate, donate
Menu, Tray, Add, About, about

interpreter_command := "cmd /k python"  ; Run Python in interactive mode.


F10::
	SetTitleMatchMode, 2  ; Allow partial match for WinTitle.
	if WinActive("Codeshare") {  ; If the window title included "Codeshare"
		Send, ^a  ; Select all text.
		code := get_selected_text()
		Send, {Left}  ; Unselect all text.
		Run, % interpreter_command  ; Run the interpreter
		Sleep, 1000  ; Wait for cmd to run.
		send_cb(code)  ; Paste the code.
		Send, {Enter 2}  ; Press Enter twice to run.
	}
return


settings:
	prompt := "Enter the command to run the interpreter of your programming language in interactive mode. The default command would run the Python interpreter on your system."
	previous_interpreter_command := interpreter_command  ; Keep the previous value in case we need to restore it.
	InputBox, interpreter_command, Interpreter command, %prompt%,, 400, 175,,,,, %interpreter_command%
	if ErrorLevel
		; This happens when the user presses Cancel (or any button other than OK)
		; The behavior of InputBox is such that the entered value is assigned to the target variable even if the user presses the Cancel button.
		; Hence, we need to restore the previous value of the target variable.
		interpreter_command := previous_interpreter_command
return

donate:
	Run, https://www.paypal.me/smndnv/5cad
	MsgBox, 0, A message of gratitude..., Thank you for considering a donation...`n`nWe don't sell our products or bug our users with ads. Instead, we rely on small donations. It is only the support of people like you that ensures we can keep helping the community by providing free apps like this one.`n`nWe truly appreciate donations of any amount, but if you can't afford to make a donation, that's totally cool too.
return

about:
	MsgBox, 0, About Codeshare Plus, Codeshare.io is an impressive online code editor that enables you to collaborate with others in real-time, using only a share link.`n`nUnfortunately, Codeshare lacks one important feature: Running code. It does not have any interpreters/compilers, and only focuses on the code editing capability.`n`nCodeshare Plus is a small utility that adds this capability to Codeshare. Anytime you press the F10 key in Codeshare, this utility collects your code and runs it in the Python interpreter on your system.`n`nBasically, this script acts as a bridge between the Codeshare interface (open in your web browser) and the Python interpreter installed on your computer.`n`nNote: Codeshare Plus is free, and is not affiliated, associated with, authorized, endorsed by, or in any way officially connected with Codeshare.io.`n`nYou can find the source code of this app and our other cool projects at: https://github.com/SamanDaneshvar
return