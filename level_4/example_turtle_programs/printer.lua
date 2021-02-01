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
--p = peripheral.wrap(tArgs[2])

-- create a new page
--p.newPage()

-- loads input string into an array where each element of the array is one word
local tWords = mysplit(sCopyToPrint)

local intLineLengthCounter = 0
local strLineText = ""

-- print each line
for i,v in ipairs(tWords) do 
  -- how long will the current line be if we add this string to it?
  intLineLengthCounter = intLineLengthCounter + string.len(v)
  -- if under 25 chars, we're safe to continue the current line
  if intLineLengthCounter < 25 then
    strLineText = strLineText .. v .. " "
  -- else, print the current line and add this string to the next line
  else
    print(strLineText)
    strLineText = v .. " "
    intLineLengthCounter = string.len(v)
  end
  --p.setCursorPos(1, i)
  --p.write(v)
end

-- this will print the page out
--p.endPage()