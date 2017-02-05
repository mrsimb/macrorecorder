# MacroRecorder
Script for LuaMacros that let you record macros without programming required.

Download link:
https://github.com/mrsimb/macrorecorder/archive/master.zip

GitHub:
https://github.com/mrsimb/macrorecorder

LuaMacros:
https://github.com/me2d13/luamacros

# Before you start
Default key for recording macro is INSERT (key code 45).  
After first start, this script will automaticaly try to use all connected keyboards and let you set them up.

# Changing hotkey
1. Look for correct key code in "KEY NAMES TABLE"
2. Change macroHotkey code in "SETTINGS SECTION"

# Recording macro
1. Press and hold your hotkey combination (for example, "c" or "ctrl+shift+a")
2. Press macro hotkey (as fast as possible!)
3. Release all keys
4. Type desired key sequence (for example, "ctrl+a, ctrl+c, right, ctrl+v")
5. Press macro hotkey again

# Removing macro:
1. Press and hold your hotkey combination
2. Release all keys
3. Press macro hotkey again, without typing any sequence

# After you set up your hotkey combinations:
1. Remove or comment "use('all')" in "SETTINGS SECTION"
2. Check keyboard (shown in log form below, when you press any key)
3. Type "use('your_keyboard_id')" in "SETTINGS SECTION"  
4. Example: use('92&0&')

# Known issues
- Can't hold TAB, SHIFT, CTRL, ALT, they sent repeatly, due to LuaMacros limitations
