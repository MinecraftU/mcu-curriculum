--[[
Example sheet music

# note block followed by delay before next note in 1/16th notes
]]

local file = {}

file.build = function()
  sheet = {17, 8, 18, 0, 10, 8, 13, 0, 5, 8,
  15, 0, 6, 16, 17, 8, 18, 0, 10, 4, 10, 4, 10, 1,
  13, 1, 20, 4, 18, 4, 18, 8,
  13, 8, 11, 8, 10, 8, 1, 8, 1, 0, 5, 0, 8, 8,
  13, 8, 6, 8, 6, 4, 8, 4, 10, 8, 8, 4, 6, 4, 6, 8}
end

return file
