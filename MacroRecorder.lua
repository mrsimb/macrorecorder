function setup()
  --[[
     EasyHotkey v0.1 beta for LuaMacros
     https://github.com/mrsimb/EasyHotkey
     LuaMacros
     https://github.com/me2d13/luamacros

     Hello. Please READ THIS information before use.

     Default key for recording macro is 19 (PAUSE/BREAK),
     to change it, just look at keyNames table and find correct number.

     By default, this script will automaticaly try to USE ALL
     connected keyboards and let you SET THEM UP.

     In that period, all keyboards will TRY to behave normally,
     but DUE TO LUASCRIPT LIMITATIONS, you wouldn't be able to:
     - hold TAB, SHIFT, CTRL, ALT keys

     To set up macro, do following:
     1. Press and hold your hotkey combination (for example, "c" or "ctrl+shift+a")
     2. Press macro hotkey (do it quickly!)
     3. Release all keys
     4. Type desired key sequence (for example, "ctrl+a, ctrl+c, right, ctrl+v")
     5. Press macro hotkey again

     To delete macro, do following:
     1. Press and hold your hotkey combination
     2. Release all keys
     3. Press macro hotkey again, without typing any sequence

     AFTER you set your up hotkey combinations,
     delete or comment "use('all')"
     and LEAVE ONLY CUSTOMIZED KEYBOARDS by using command:
     "use('customized_keyboard_id')"
  --]]

  macroHotkey = 19
  minimize = false

  use('all') -- DELETE AFTER SETTING UP!
  use('customized_keyboard_id')
end

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
  [220] = '\\',
  [221] = ']',
  [219] = '[',
  [222] = '\''
}

keyboards = {}
target = nil
handler = nil

hotkey = 19
minimize = true

sequence = ''

function getKeyName(scanCode)
  if (keyNames[scanCode]) then
    return keyNames[scanCode]
  end
  return nil
end

function init()
  clear()
  lmc_print_devices()
  handler = listener
  setup()
  if (minimize) then
    lmc_minimize()
  end
end

function anyKeyPressed()
  for i = 1, #keyboards do
    if (keyboards[i].used) then
      for j = 8, 222 do
        if (keyboards[i].keyStates[j] == true) then
          return true
        end
      end
    end
  end
  return false
end

function createKeyboard(id)
  local kb = {}
  kb.id = id
  kb.map = {}
  kb.keyStates = {}
  kb.sequence = ''
  kb.used = false

  function kb.reciever(scanCode, direction)
    reciever(kb, scanCode, direction)
  end

  lmc_device_set_name(id, id)
  lmc_set_handler(id, kb.reciever)

  return kb
end

function use(id)
  -- check if already exists
  for i = 1, #keyboards do
    if (keyboards[id] == id) then
      return
    end
  end

  if (id == 'all') then
    for i = 1, 255 do
      use(string.format("%02x", i) .. '&0&')
    end
  else
    keyboards[#keyboards+1] = createKeyboard(id)
  end
end

function useAllKeyboards()
  for i = 1, 255 do
    use(string.format("%02x", i) .. '&0&')
  end
end

function getModifiers(caller)
  local modifiers = ''
  if (caller.keyStates[9] == true) then  modifiers = modifiers .. getKeyName(9) end
  if (caller.keyStates[16] == true) then  modifiers = modifiers .. getKeyName(16) end
  if (caller.keyStates[17] == true) then  modifiers = modifiers .. getKeyName(17) end
  if (caller.keyStates[18] == true) then  modifiers = modifiers .. getKeyName(18) end
  return modifiers
end

function setHotkey(target, sequence, action)
  if (action == '') then
    target.map[sequence] = nil
  else
    target.map[sequence] = action
  end
end

function editor(caller, scanCode, direction)
  if (direction == 1) then
    if (scanCode == macroHotkey) then
      setHotkey(target, target.sequence, sequence)
      print(target.id .. 'hotkey \"' .. target.sequence .. '\" set to \"' .. sequence .. '\"')
      sequence = ''
      handler = listener
      print('leaving editor mode')
    else
      sequence = sequence .. getKeyName(scanCode)
      print('id ' .. caller.id .. ' sequence \"' .. sequence .. '\"')
    end
  else
    if (not suspendInput and (scanCode >= 16 and scanCode <= 18) or scanCode == 9) then
      sequence = sequence .. ')'
    end
    if (not anyKeyPressed()) then
      suspendInput = false
    end
  end
end

function listener(caller, scanCode, direction)
  if (direction == 1) then
    if (scanCode == macroHotkey) then
      if (caller.sequence ~= '') then
        suspendInput = true
        target = caller
        handler = editor
        print('entering editor mode')
      end
    else
      caller.sequence = caller.sequence .. getKeyName(scanCode)
      print('id ' .. caller.id .. ' sequence \"' .. caller.sequence .. '\"')

      if (caller.map[caller.sequence]) then
        print('id ' .. caller.id .. ' hotkey \"' .. caller.sequence .. '\" sending \"' .. caller.map[caller.sequence] .. '\"')
        lmc_send_keys(caller.map[caller.sequence])
      else
        lmc_send_keys(getModifiers(caller) .. getKeyName(scanCode))
      end
    end
  else
    if (not anyKeyPressed()) then
      caller.sequence = ''
      print('keys released')
    end
  end
end

function reciever(caller, scanCode, direction)
  --print('id ' .. caller.id .. ' recieved ' .. scanCode .. ' ' .. direction)
  if (direction == 1) then
    caller.used = true
    caller.keyStates[scanCode] = true
  else
    caller.keyStates[scanCode] = false
  end

  handler(caller, scanCode, direction)
end

init()
