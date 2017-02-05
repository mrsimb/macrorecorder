# MacroRecorder
Script for LuaMacros that let you record macros without programming required.

Download link:
https://github.com/mrsimb/macrorecorder/archive/master.zip

GitHub:
https://github.com/mrsimb/macrorecorder

TODO:
- Saving config (for now, all recorded macros will be deleted upon app exit)

Default key for recording macro is 45 (INSERT).

By default, this script will automaticaly try to use ALL connected keyboards and let you SET THEM UP.

In that period, all keyboards will TRY to behave normally, but due to LUASCRIPT LIMITATIONS, you wouldn't be able to:
- hold TAB, SHIFT, CTRL, ALT keys (they will be sent repeatly)

# Changing hotkey
1. Look for correct key code in "KEY NAMES TABLE"
2. Change macroHotkey code in "SETTINGS SECTION"

# Recording macro
1. Press and hold your hotkey combination (for example, "c" or "ctrl+shift+a")
2. Press macro hotkey (do it quickly!)
3. Release all keys
4. Type desired key sequence (for example, "ctrl+a, ctrl+c, right, ctrl+v")
5. Press macro hotkey again

# To delete macro, do following:
1. Press and hold your hotkey combination
2. Release all keys
3. Press macro hotkey again, without typing any sequence

# AFTER you set up your hotkey combinations, do following:
1. Go to "SETTINGS SECTION"
2. Comment or delete "use('all')" line
3. Type "use('your_customized_keyboard_id')"
4. ID of triggered keyboard is shown in log form below, when you press any key.

# Known issues
* can't hold TAB, SHIFT, CTRL, ALT, they sent repeatly, due to LuaMacros limitations
