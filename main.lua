-- Fur-o-tron game --

local utf8 = require("utf8")

function love.load()
   -- Sprites --

   chatbox = love.graphics.newImage("sprites/chatbox.png")

   versus = {
      name = "Versus",
      color = {192, 229, 127},
      happy = love.graphics.newImage("sprites/versus/happy.png"),
      laughing = love.graphics.newImage("sprites/versus/laughing.png"),
      embarrassed = love.graphics.newImage("sprites/versus/embarrassed.png"),
      surprised = love.graphics.newImage("sprites/versus/surprised.png")
   }
   
   -- Font --

   font = {
      text = love.graphics.newFont("font/Gilles_Handwriting.ttf", 50),
      name = love.graphics.newFont("font/Gilles_Handwriting.ttf", 40)
   }

   -- Texte --

   username = "You"

   user = {
      color = {255, 255, 255},
      gender = 0
   }
   
   dialogue = {
      text = {
	 { versus.name, versus.happy, versus.color, "Salut l'ami ! Je suis Versus, je serai ton visagiste personnel pour cette session.\n\nQuel est ton nom ?", {}, 2},
	 { versus.name, versus.laughing, versus.color, "@@username ? C'est un joli nom !\nBien, nous allons pouvoir commencer !\nJe vais te poser quelques questions, ton avatar en furry apparaitra a la fin ! Es-tu pret ?" , {"Oui", "Non"}, {4, 3}},
	 { versus.name, versus.surprised, versus.color, "Oh, c'est bien dommage... A une autre fois alors !", {}, function() love.event.quit() end},
	 { versus.name, versus.happy, versus.color, "Super ! Voici la premiere question.\n\nEs-tu un garcon ou une fille ?", {"Un garcon", "Une fille"}, {5, 100}},
	 { "@@username", nil, user.color, "Sans contrefacon, je suis un garcon !", {}, 6},
	 { versus.name, versus.happy, versus.color, "Donc tu es un garcon. C'est bon a savoir !", {}, 1}
      }
   }
   
   text = {
      name = dialogue.text[1][1],
      sprite = dialogue.text[1][2],
      color = dialogue.text[1][3],
      text = dialogue.text[1][4],
      x = 280,
      y = 750,
      n = 1,
      speed = 30,
      collide = 1350
   }

   -- Global variables --
   
   noxt = 1
   gamestate = "entername"
   user_choice = 0
end

function debog()
   love.graphics.print(gamestate, 10, 10)
   love.graphics.print(noxt, 10, 50)
   love.graphics.print(user_choice, 10, 90)
   love.graphics.print(username, 10, 130)
   love.graphics.print(user.gender, 10, 170)
end

function love.update(dt)
   if (text.n <= #text.text) then
      local char = text.text:sub(text.n, text.n)
      
      if (char == "." or char == "," or char == "?" or char == "!") then
	 text.n = text.n + dt * (text.speed / 10)
      else
	 text.n = text.n + dt * text.speed
      end
   end
end
   
function love.keypressed(key, isrepeat)
   if (key == "escape") then
      love.event.quit()
   end
   
   if (key == "space") then
      text.speed = text.speed * 3
   end

   if (key == "return" and text.n > #text.text) then
      if (gamestate == "normal" or gamestate == "entername") then
	 noxt = dialogue.text[noxt][6]
      else
      	 noxt = dialogue.text[noxt][6][user_choice + 1]
      end
      if (type(noxt) == "function") then
	 noxt = noxt()
      end
      if (noxt == 1) then
	 gamestate = "entername"
      elseif (dialogue.text[noxt][5][1]) then
	 gamestate = "choice"
	 user_choice = 0
      elseif (dialogue.text[noxt][5][1] == nil) then
	 gamestate = "normal"
      end

      changeText(dialogue.text[noxt][1], dialogue.text[noxt][3], dialogue.text[noxt][4], dialogue.text[noxt][2], 280, 750, 1, 30)
   end

   if (gamestate == "choice") then
      if key == "down" then
	 user_choice = user_choice + 1
      elseif key == "up" then
	 user_choice = user_choice - 1
      end
      user_choice = user_choice % #dialogue.text[noxt][6]
   end

   if (gamestate == "entername" and text.n > #text.text) then
      if key == "backspace" then
	 local byteoffset = utf8.offset(username, -1)

	 if byteoffset then
	    username = username:sub(1, byteoffset -1)
	 end
      end
   end
end

function love.keyreleased(key)
   if (key == "space") then
      text.speed = text.speed / 3
   end
end

function love.textinput(t)
   if (gamestate == "entername" and text.n > #text.text) then
      if (#username < 16) then
	 if ((t >= "a" and t <= "z") or (t >= "A" and t <= "Z") or t == "-") then
	    username = string.gsub("-"..username..t, "(-[a-zA-Z])", function (a) return string.upper(a) end):sub(2, -1)
	 end
      end
   end
end

function love.draw() 
   debog()
   if not (text.sprite == nil) then 
      love.graphics.draw(text.sprite, 1200, 238, 0, 0.7)
   end
   love.graphics.draw(chatbox, 200, 650, 0, 0.9)
   love.graphics.setFont(font.name)
   love.graphics.printf({text.color, text.name}, 250, 665, 300, "center", 0, 1.3, 1)
   love.graphics.setFont(font.text)
   love.graphics.printf({text.color, text.text:sub(1, math.floor(text.n))}, text.x, text.y, text.collide)
   if (gamestate == "choice" and text.n > #text.text) then
      local x, y = 750, (650 / (#dialogue.text[noxt][5] + 1)) + 25
      for i = 1, #dialogue.text[noxt][5] do
	 if (user_choice == i - 1) then
	    love.graphics.printf({{225,199,42}, dialogue.text[noxt][5][i]}, x, y + (650 / (#dialogue.text[noxt][4] + 1)) * (i - 1), 200, "center")
	 else
	    love.graphics.printf(dialogue.text[noxt][5][i], x, y + (650 / (#dialogue.text[noxt][5] + 1)) * (i - 1), 200, "center")
	 end
      end
   end
end

function changeText(_name, _color, _text, _sprite, _x, _y, _n, _speed)
   text.name = myString(_name)
   text.color = _color
   text.text = myString(_text)
   text.sprite = _sprite
   text.x = _x
   text.y = _y
   text.n = _n
   speed = _speed
   user_choice = 0
end

function myString(str)
   return string.gsub(str, "@@([a-zA-Z_][_a-zA-Z0-9]*)", function (a) return _G[a] or "@@"..a end)
end
