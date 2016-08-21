--[[
Server that listens on the music protocol
and sends a redstone signal to activate
a note block if the msg matches the computer label
]]

rednet.open("top")
while true do
  local sender, msg, prot = rednet.receive("music")
  if msg == os.getComputerLabel() then
    print("message received")
    redstone.setOutput("back", true)
    sleep(0.11)
    redstone.setOutput("back", false)
  end
end
