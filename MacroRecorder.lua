--------------------------------------------------------------------------------
------------------------------------ README ------------------------------------
--------------------------------------------------------------------------------
--[[
# MacroRecorder
Script for LuaMacros that let you record macros without programming required.

Download link:
https://github.com/mrsimb/macrorecorder/archive/master.zip

GitHub:
https://github.com/mrsimb/macrorecorder

LuaMacros:
https://github.com/me2d13/luamacros

## Before you start
This script is only for use with additional keypad/keyboard.

After initial start of the script, all your keyboards will try to work as usual,
but will lag in some way. That is due to LuaMacros limitations.

When you're done with recording macros for your keypad, go to "SETTINGS SECTION"
and change use("all") to use("your_keypad_id").

ID is shown in log form of LuaMacros window every time you press any key.
Default record hotkey is INSERT (key code 45).

## How to use
1. Press and hold your hotkey combination ("ctrl c", for example)
2. Press INSERT (do it quickly!) and release all keys
3. Type your macro
4. Press INSERT again
5. Done. Now every time you press "ctrl c" script will reproduce recorded key sequence.

## Removing macro:
1. Press and hold your hotkey combination
2. Press INSERT and release all keys
3. Press INSERT again, without typing any sequence

## Changing record hotkey
1. Look for correct key code in "KEY NAMES TABLE"
2. Change macroHotkey code in "SETTINGS SECTION"

## Known issues
- By strange reason, recording with non-english keyboard layouts won't work (for me at least).
- Recording shift+(abc), and sending it results Abc, not ABC. This is a LuaMacros bug.
--]]

--------------------------------------------------------------------------------
------------------------------- SETTINGS SECTION -------------------------------
--------------------------------------------------------------------------------

function setup()
  load('macros.lua')
  minimize = false

  -- before all macros recorded
  use('all')

  -- after all macros recorded, remove use('all') and type
  use('your_customized_keypad_id')
  -- example:
  use('92&0&')
end

--------------------------------------------------------------------------------
------------------------------- KEY NAMES SECTION ------------------------------
--------------------------------------------------------------------------------

keyNames = {
  [8] = '{backspace}',
  [9] = '&(',
  [13] = '{enter}',
  [16] = '+(',
  [17] = '^(',
  [18] = '%(',
  [19] = '{pause}',
  [20] = '{capslock}',
  [27] = '{escape}',
  [32] = ' ',
  [33] = '{pgup}',
  [34] = '{pgdn}',
  [35] = '{end}',
  [36] = '{home}',
  [37] = '{left}',
  [38] = '{up}',
  [39] = '{right}',
  [40] = '{down}',
  [44] = '{prtsc}',
  [45] = '{ins}',
  [46] = '{del}',
  [48] = '0',
  [49] = '1',
  [50] = '2',
  [51] = '3',
  [52] = '4',
  [53] = '5',
  [54] = '6',
  [55] = '7',
  [56] = '8',
  [57] = '9',
  [65] = 'a',
  [66] = 'b',
  [67] = 'c',
  [68] = 'd',
  [69] = 'e',
  [70] = 'f',
  [71] = 'g',
  [72] = 'h',
  [73] = 'i',
  [74] = 'j',
  [75] = 'k',
  [76] = 'l',
  [77] = 'm',
  [78] = 'n',
  [79] = 'o',
  [80] = 'p',
  [81] = 'q',
  [82] = 'r',
  [83] = 's',
  [84] = 't',
  [85] = 'u',
  [86] = 'v',
  [87] = 'w',
  [88] = 'x',
  [89] = 'y',
  [90] = 'z',
  [96] = '{num0}',
  [97] = '{num1}',
  [98] = '{num2}',
  [99] = '{num3}',
  [100] = '{num4}',
  [101] = '{num5}',
  [102] = '{num6}',
  [103] = '{num7}',
  [104] = '{num8}',
  [105] = '{num9}',
  [106] = '{nummultiply}',
  [107] = '{numplus}',
  [109] = '{numminus}',
  [110] = '{numdecimal}',
  [111] = '{numdivide}',
  [112] = '{f1}',
  [113] = '{f2}',
  [114] = '{f3}',
  [115] = '{f4}',
  [116] = '{f5}',
  [117] = '{f6}',
  [118] = '{f7}',
  [119] = '{f8}',
  [120] = '{f9}',
  [121] = '{f10}',
  [122] = '{f11}',
  [123] = '{f12}',
  [124] = '{f13}',
  [125] = '{f14}',
  [126] = '{f15}',
  [127] = '{f16}',
  [144] = '{numlock}',
  [145] = '{scrolllock}',
  [160] = '+<(',
  [161] = '+>(',
  [162] = '^<(',
  [163] = '^>(',
  [164] = '%<(',
  [165] = '%>(',
  [186] = ';',
  [187] = '=',
  [188] = ',',
  [189] = '-',
  [190] = '.',
  [191] = '/',
  [192] = '`',
  [220] = '\\',
  [221] = ']',
  [219] = '[',
  [222] = '\''
}

--------------------------------------------------------------------------------
---------------------------------- VARIABLES -----------------------------------
--------------------------------------------------------------------------------

macroHotkey = 45
minimize = false

keyboards = {}
target = nil
sequence = ''

handle = nil
suspendInput = false

config = ''

--------------------------------------------------------------------------------
--------------------------- KEYBOARD INITIALIZATION ----------------------------
--------------------------------------------------------------------------------

function init(kb)
  if (kb.reciever == nil) then
    function kb.reciever(scanCode, direction)
      input(kb, scanCode, direction)
    end

    lmc_device_set_name(kb.id, kb.id)
    lmc_set_handler(kb.id, kb.reciever)
  end
end

function use(id)
  print('using ' .. id)

  for n, kb in pairs(keyboards) do
    if (kb.id == id) then
      --keyboard exists, just add reciever then return
      init(kb)
      return
    end
  end

  -- if id == 'all' use all keyboards from 00&0& to ff&0&
  -- if it not exist
  -- create map and id for it
  -- add reciever
  if (id == 'all') then
    for i = 1, 255 do
      use(string.format("%02x", i) .. '&0&')
    end
  else
    local kb = {}
    kb.id = id
    kb.map = {}
    init(kb)
    keyboards[#keyboards+1] = kb
  end

  -- other stuff will be added right after keyboard is used in input function
end

--------------------------------------------------------------------------------
-------------------------------- INPUT RECIEVER --------------------------------
--------------------------------------------------------------------------------

function input(caller, scanCode, direction)
  -- if no keyStates, add it and other stuff
  if (caller.keyStates == nil) then
    caller.keyStates = {}
    caller.sequence = ''
  end

  if (direction == 1) then
    caller.keyStates[scanCode] = true
  else
    caller.keyStates[scanCode] = false
  end

  handle(caller, scanCode, direction)
end

--------------------------------------------------------------------------------
------------------------------- HOTKEY ASSIGNING -------------------------------
--------------------------------------------------------------------------------

function setMacro(target, sequence, action)
  if (action == '') then
    target.map[sequence] = nil
  else
    target.map[sequence] = action
  end
end

--------------------------------------------------------------------------------
--------------------------------- EDIT HANDLER ---------------------------------
--------------------------------------------------------------------------------

function edit(caller, scanCode, direction)
  if (direction == 1) then
    if (isDown(macroHotkey)) then
      setMacro(target, target.sequence, sequence)
      print('id ' .. target.id .. ' hotkey \"' .. target.sequence .. '\" set to \"' .. sequence .. '\"')

      sequence = ''

      save()
      print('saving to config.lua')

      handle = listen
    else
      sequence = sequence .. getKeyName(scanCode)
      print('id ' .. caller.id .. ' sequence \"' .. sequence .. '\"')
    end
  else
    if (not suspendInput and (scanCode >= 16 and scanCode <= 18  or scanCode == 9)) then
      sequence = sequence .. ')'
    end
    if (not anyKeyPressed()) then
      suspendInput = false
    end
  end
end

--------------------------------------------------------------------------------
-------------------------------- LISTEN HANDLER --------------------------------
--------------------------------------------------------------------------------

function listen(caller, scanCode, direction)
  if (direction == 1) then
    if (isDown(macroHotkey)) then
      if (caller.sequence ~= '') then
        suspendInput = true
        target = caller
        handle = edit
        print('entering edit mode')
      end
    else
      caller.sequence = caller.sequence .. getKeyName(scanCode)
      print('id ' .. caller.id .. ' recieved \"' .. caller.sequence .. '\"')

      if (caller.map[caller.sequence] ~= nil) then
        print('id ' .. caller.id .. ' hotkey \"' .. caller.sequence .. '\" sending \"' .. caller.map[caller.sequence] .. '\"')
        lmc_send_keys(caller.map[caller.sequence])
      else
        lmc_send_keys(getModifiers(caller) .. getKeyName(scanCode))
      end
    end
  else
    if (not anyKeyPressed()) then
      caller.sequence = ''
      print('all keys released')
      print()
    end
  end
end

--------------------------------------------------------------------------------
------------------------------- KEYPRESS STUFF ---------------------------------
--------------------------------------------------------------------------------

function getKeyName(scanCode)
  if (keyNames[scanCode] ~= nil) then
    return keyNames[scanCode]
  end
  return nil
end

function anyKeyPressed()
  for i = 1, #keyboards do
    if (keyboards[i].keyStates ~= nil) then
      for j = 8, 222 do
        if (keyboards[i].keyStates[j] == true) then
          return true
        end
      end
    end
  end
  return false
end

function isDown(scanCode)
  for i = 1, #keyboards do
    if (keyboards[i].keyStates ~= nil and keyboards[i].keyStates[scanCode]) then
      return true
    end
  end
  return false
end

function getModifiers(caller)
  local modifiers = ''

  -- TAB
  if (caller.keyStates[9] == true) then
    modifiers = modifiers .. getKeyName(9)
  end

  -- SHIFT
  if (caller.keyStates[16] == true) then
    modifiers = modifiers .. getKeyName(16)
  end

  -- CTRL
  if (caller.keyStates[17] == true) then
    modifiers = modifiers .. getKeyName(17)
  end

  -- ALT
  if (caller.keyStates[18] == true) then
    modifiers = modifiers .. getKeyName(18)
  end

  return modifiers
end


--------------------------------------------------------------------------------
---------------------------------- LOAD / SAVE ---------------------------------
--------------------------------------------------------------------------------

function load(path)
  config = path

  local file = io.open(path, 'r')

  if file then
    dofile(path)

    for n, kb in pairs(keyboards) do
      use(kb.id)
    end

    file.close()

    print(path .. ' loaded')
    return
  end

  print(path .. ' not found')
end

function save()
  file = io.open(config, 'w')
  io.output(file)

  io.write('keyboards = {\n')

  for n, kb in pairs(keyboards) do
    if (kb.keyStates ~= nil) then
      io.write('  {\n')
      io.write('    id = \'', kb.id, '\',\n')

      io.write('    map = {\n')

      for k, v in pairs(kb.map) do
        io.write('      [\'', k, '\'] = \'', v, '\',\n')
      end

      io.write('    }\n')
      io.write('  },\n')
    end
  end

  io.write('}\n')

  file.close()
end

--------------------------------------------------------------------------------
------------------------------------ STARTUP -----------------------------------
--------------------------------------------------------------------------------

function start()
  clear()
  setup()
  lmc_print_devices()
  handle = listen
  if (minimize) then
    lmc_minimize()
  end
end

start()

