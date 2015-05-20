local player_mt = {}
local player = {}

function player.new()
	self = setmetatable({}, {__index = player_mt})
	
	self.x = 0
	self.y = 0
	self.name = "cake"
	self.speed = 10
	
	return self
end

return player