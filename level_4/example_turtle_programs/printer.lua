local function printUsage()
  print( "Usage:" )
  print( "print <pastebin code> <side>" )
end

local tArgs = { ... }
if #tArgs < 2 then
  printUsage()
  return
end

if not http then
  printError( "Pastebin requires http API" )
  printError( "Set http_enable to true in ComputerCraft.cfg" )
  return
end

local function get(paste)
  write( "Connecting to pastebin.com... " )
  local response = http.get(
      "http://pastebin.com/raw/"..textutils.urlEncode( paste )
  )
      
  if response then
      print( "Success." )
      
      local sResponse = response.readAll()
      response.close()
      return sResponse
  else
      print( "Failed." )
  end
end

function mysplit (inputstr)
  local t = {}
  for str in string.gmatch(inputstr, "([^%s]+)") do
    table.insert(t, str)
  end
  return t
end

-- get the string to print from pastebin
sCopyToPrint = get(tArgs[1])

-- attach to the printer
p = peripheral.wrap(tArgs[2])

-- loads input string into an array where each element of the array is one word
local tWords = mysplit(sCopyToPrint)

local iLineLengthCounter = 0
local sLineText = ""
local iLineCount = 1

-- print a page
for i=1,21,1 do
  -- create a new page
  p.newPage()
  -- print each line
  for i, v in ipairs(tWords) do
    -- how long will the current line be if we add this string to it?
    iLineLengthCounter = iLineLengthCounter + string.len(v) + 1
    -- if under 25 chars, we're safe to continue the current line
    if iLineLengthCounter < 25 then
      sLineText = sLineText .. v .. " "
    -- else, print the current line and add this string to the next line
    else
      p.write(sLineText)
      -- put current word on next line
      sLineText = v .. " "
      -- increment the line counter
      iLineLengthCounter = string.len(v) + 1
      -- set cursor on next line
      iLineCount = iLineCount + 1
      p.setCursorPos(1, iLineCount)
    end
  end
  -- this will print the page out
  p.endPage()
  -- reset line count and cursor position
  iLineCount = 1
  p.setCursorPos(1, iLineCount)
end
