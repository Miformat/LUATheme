function love.load(args)
	math.randomseed(os.time())
	cakePlayer = require("player")
	cakeNPC = require("NPC")
	player = cakePlayer.new()
	NPCTab = {}
	ChocTab = {}
	timer = 0
	maxTime = 80
	actionTime = maxTime/2
	timerChoc = 0
	timeStraw = 3
	timeHit = 51
	lifetowin = 5
	haveWin = false
	background = love.graphics.newImage("img/background.gif")
	backgroundend = love.graphics.newImage("img/background_end.gif")
	portalcake = love.graphics.newImage("img/portalcake.gif")
	turret = love.graphics.newImage("img/turret.gif")
	miam = love.audio.newSource("sound/miam_short.wav", "static")
	wee = love.audio.newSource("sound/wee.wav", "static")
	strawberry = love.audio.newSource("sound/strawberry.mp3")
	portal = love.audio.newSource("sound/portal.mp3")
	laugh = love.audio.newSource("sound/laugh.wav")
	love.audio.play(strawberry)
end

function love.update(dt)
	playing = strawberry:isPlaying( )
	endplaying = portal:isPlaying( )
	if playing == false and endplaying == false then
		love.audio.play(strawberry)
	end
	if player.life == 0 then
		strawberry:stop()
		portal:stop()
		love.audio.play(laugh)
		love.load()
	end
	if player.life > lifetowin then
		haveWin = true
	end
	if haveWin then
		strawberry:stop()
		player.img = portalcake
		love.audio.play(portal)
		timer = 1
	else
		portal:stop()
	end
	player.truePX = player.x + (player.width*player.life) / 2
	player.truePY = player.y + (player.height*player.life) / 2
	timerChoc = timerChoc - 1
	if timeHit < 51 then
		timeHit = timeHit - 1
		player:hit(timeHit)
		if timeHit < 0 then
			timeHit = 51
		end
		player.hurt = true
	else
		player.hurt = false
	end
	timer = timer + 1
	if timer % maxTime == 0 then
		NewNPC = cakeNPC.new(0)
		NewNPC.move = love.math.random(4)
		onPlayer =  player:detectCol(player.x,player.y,(player.width*player.life),(player.height*player.life),NewNPC.x,NewNPC.y,NewNPC.width,NewNPC.height)
		--while onPlayer do
			NewNPC.x = love.math.random(800)
			NewNPC.y = love.math.random(600)
		--	onPlayer =  player:detectCol(player.x,player.y,(player.width*player.life),(player.height*player.life),NewNPC.x,NewNPC.y,NewNPC.width,NewNPC.height)
		--end
		table.insert(NPCTab,NewNPC)
	end
	if timer % (maxTime*timeStraw) == 0 then
		NewNPC = cakeNPC.new(1)
		table.insert(NPCTab,NewNPC)
	end
	for i,mob in ipairs(NPCTab) do
		isHit = player:detectCol(player.x,player.y,(player.width*player.life),(player.height*player.life),mob.x,mob.y,mob.width,mob.height)
		for j,choc in ipairs(ChocTab) do
			isChocHit = player:detectCol(mob.x,mob.y,mob.width,mob.height,choc.x,choc.y,(choc.width*choc.life),(choc.height*choc.life))
			if isChocHit then 
				table.remove(NPCTab,i)
				love.audio.play(miam)
				choc.life = choc.life - 1
				if choc.life == 0 then
					table.remove(ChocTab,j)
				end
			end
		end
		if mob.id == 0 then
			if haveWin == false then
				if mob.move == 1 then
					mob.x = mob.x + mob.speed
				elseif mob.move == 2 then
					mob.y = mob.y - mob.speed
				elseif mob.move == 3 then
					mob.x = mob.x - mob.speed
				elseif mob.move == 4 then
					mob.y = mob.y + mob.speed
				end
				if timer % actionTime == 0 then
					--mob.move = love.math.random(4) //harcore mode disable
				end
				if mob.x > 800 then
					mob.x = 1
				end
				if mob.x < 0 then
					mob.x = 799
				end
				if mob.y > 600 then
					mob.y = 1
				end
				if mob.y < 0 then
					mob.y = 599
				end
				if isHit and player.hurt == false then
					player.life = player.life - 1
					timeHit = timeHit - 1
					love.audio.play(miam)
					table.remove(NPCTab,i)
				end
			else
				mob.img = turret
			end
		end
		
		if mob.id == 1 then
			if isHit then
				player.life = player.life + 1
				love.audio.play(wee)
				table.remove(NPCTab,i)
			end
		end
	end
	if love.keyboard.isDown(" ") and timerChoc < 0 then
		if haveWin then
			NewNPC = cakeNPC.new(3)
		else
			NewNPC = cakeNPC.new(2)
		end
		NewNPC.x = player.truePX
		NewNPC.y = player.truePY
		NewNPC.life = math.floor(player.life/2)
		table.insert(ChocTab,NewNPC)
		timerChoc = 100
	end
	if love.keyboard.isDown("right") then
	   player.x = player.x + player.speed
	end
	if love.keyboard.isDown("left") then
		player.x = player.x - player.speed
	end
	if love.keyboard.isDown("down") then
		player.y = player.y + player.speed
	end
	if love.keyboard.isDown("up") then
		player.y = player.y - player.speed
	end
	if player.x > 800 then
		player.x = 1
	end
	if player.x < 0 then
		player.x = 799
	end
	if player.y > 600 then
		player.y = 1
	end
	if player.y < 0 then
		player.y = 599
	end
end

function love.draw()
	if haveWin == false then
		love.graphics.draw(background, 0,0)
	else
		love.graphics.draw(backgroundend, 0,0)
	end
	for _,choc in ipairs(ChocTab) do
		love.graphics.draw(choc.img, choc.x, choc.y, 0,choc.life,choc.life)
	end
	for _,NPC in ipairs(NPCTab) do
		love.graphics.draw(NPC.img, NPC.x, NPC.y)
	end
	love.graphics.draw(player.img, player.x, player.y,0,player.life,player.life)
end