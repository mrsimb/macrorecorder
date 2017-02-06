# MacroRecorder
Script for LuaMacros that let you record macros without programming required.

Download link:
https://github.com/mrsimb/macrorecorder/archive/master.zip

GitHub:
https://github.com/mrsimb/macrorecorder

LuaMacros:
https://github.com/me2d13/luamacros

## Before you start
After initial start of the script, all your keyboard will try to work as usual, but will lag in some way. That is due to LuaMacros limitations.  
When you're done with setting your macros, go to "SETTINGS SECTION" and change use("all") to use("your_keypad_id"). Keyboard id is shown in log form of LuaMacros window every time you press any key.  
Default record hotkey is INSERT (key code 45).

## How to use
1. Press and hold your hotkey combination ("ctrl c", for example)
2. Press INSERT (do it quickly!) and release all keys
3. Type your macro
4. Press INSERT again
5. Done. Now every time you press "ctrl c" script will reproduce recorded key sequence.

## Removing macro:
1. Press and hold your hotkey combination
2. Release all keys and press INSERT again, without typing any sequence

## Changing record hotkey
1. Look for correct key code in "KEY NAMES TABLE"
2. Change macroHotkey code in "SETTINGS SECTION"

## Known issues
- Macros no saving. There is just no save function at the time, i'm working on it.
- By strange reason, recording with non-english keyboard layouts won't work (for me at least).
- Recording shift+(abc), and sending it results Abc, not ABC. This is a LuaMacros bug.
