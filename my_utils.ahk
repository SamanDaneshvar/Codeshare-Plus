#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#SingleInstance Force  ; When reloading the script, skips the dialog box and replaces the old instance automatically, which is similar in effect to the Reload command.


get_selected_text() {
	; Obtain the selected text through the clipboard
	; Refer to the comments for the ^!':: hotkey (same idea)
	
	priorClipboardContents := ClipboardAll  ; Save the entire contents of the clipboard (including pictures and formatting) to a variable
	Clipboard :=  ; Empty the clipboard.
	Send, ^c  ; Ctrl+C (to copy the selected text to the clipboard)
	ClipWait, 0.15  ; Wait until the clipboard contains some data (timeout = 0.15 seconds)
	if ErrorLevel  ; If timeout, which means: If no data arrives to the clipboard within the timeout limit.
		TrayTip, %A_ScriptName%, Timeout. The attempt to copy text onto clipboard failed.,, 2
	else
		selectedText := Clipboard  ; Save the textual contents of the clipboard to the variable
	Clipboard := priorClipboardContents  ; Restore the original clipboard
	priorClipboardContents :=  ; Empty the variable to free up the memory
	
	return selectedText
}


send_cb(string_to_send) {
	; Send a string via clipboard
	
	priorClipboardContents := ClipboardAll  ; Save the entire contents of the clipboard (including pictures and formatting) to a variable
	Clipboard :=  ; Empty the clipboard.
	Clipboard := string_to_send  ; Copy the string to send onto the clipboard.
	ClipWait, 0.15  ; Wait until the clipboard contains some data (timeout = 0.15 seconds)
	if ErrorLevel  ; If timeout, which means: If no data arrives to the clipboard within the timeout limit.
		TrayTip, %A_ScriptName%, Timeout. The attempt to copy text onto clipboard failed.,, 2
	Send, ^v  ; This pastes the clipboard.
	Sleep, 100  ; Wait for 0.1 seconds
	Clipboard := priorClipboardContents  ; Restore the original clipboard
	priorClipboardContents :=  ; Empty the variable to free up the memory
	
	return
}
