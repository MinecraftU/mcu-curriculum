--[[
Created by atvaccaro, 2014

Runs a straight course at a random pace
launching a firework at the end (in a dispenser)
]]

function runRace()
  local blocks = 0
  while not turtle.detect() do
    if turtle.getFuelLevel() < 1 then
      turtle.refuel(1)
    end


    local wait = math.random() * 2
    os.sleep(wait)

    local turbo = math.random(5)
    if turbo == 1 then
      turtle.forward()
      blocks = blocks + 1
      if turtle.detect() then
        firework()
      end
    end

    turtle.forward()
    blocks = blocks + 1
    if turtle.detect() then
      firework()
    end
  end

  sleep(5)

  for i = 1,blocks do
    if turtle.getFuelLevel() < 1 then
      turtle.refuel(1)
    end
    turtle.back()
  end
end

function firework()
  rs.setOutput("front", true)
  sleep(0.1)
  rs.setOutput("front", false)
end

while true do
  os.pullEvent()
  if rs.getInput("back") then
    print("Starting race")
    runRace()
  end
end
