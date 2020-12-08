pico-8 cartridge // http://www.pico-8.com
version 29
__lua__
function _init()
	cls()
	rot = 0
	rotable = {
		rot=0,
		mapx=0,
		mapy=0,
		mapw=1,
		maph=1,
		x,y = 64,64,
		new = function(self, o)
			o= o or {}
			setmetatable(o,self)
			self.__index = self
			return o
		end,
		w = function(self) 
			return self.mapw*8
		end,
		h = function(self) 
			return self.maph*8
		end,
		rad = function(self) 
			return sqrt((self:w()/2)^2+(self:h()/2)^2)
		end,
		to_polar = function(x, y, rad, rot, offset_x, offset_y)
			local ang = atan2(x, y)+(rot or 0)
			return rad*cos(ang)+offset_x+0.5, rad*sin(ang)+offset_y+0.5
		end,
		tl = function(self)
			
			return self.to_polar(-self:w()/2, -self:h()/2, self:rad(), self.rot, self.x, self.y )
		end,
		tr = function(self)
			return self.to_polar(self:w()/2, -self:h()/2, self:rad(), self.rot, self.x, self.y )
		end,
		bl = function(self)
			return self.to_polar(-self:w()/2, self:h()/2, self:rad(), self.rot, self.x, self.y )
		end,
		br = function(self)
			return self.to_polar(self:w()/2, self:h()/2, self:rad(), self.rot, self.x, self.y )
		end,
		outline = function(self)
			local tlx, tly = self:tl()
			local trx, try = self:tr()
			local blx, bly = self:bl()
			local brx, bry = self:br()
			line(tlx, tly, trx, try, 14)
			line( trx, try, brx, bry, 14)
			line( brx, bry, blx, bly, 14)
			line( blx, bly, tlx, tly, 14)
		end,
		fill = function(self) 
			local tlx, tly = self:tl() -- top right x
			local trx, try = self:tr() -- top right y
			local blx, bly = self:bl() -- bottom left x 
			local brx, bry = self:br() -- bottom left y

			if (self.rot < 0.25) then
				local topy = tly
				local bottomy = tly
				local width = brx-tlx
				local part1_top_dy = (try - tly)/(trx-tlx)
				local part2_top_dy = (bry -try)/(brx -trx)
				local part1_bottom_dy =(bly-tly)/(blx-tlx)
				local part2_bottom_dy =(bry-bly)/(brx-blx)
				for i= 0, width do
					line(tlx+i, topy, tlx+i, bottomy, i)
					if (tlx + i <= trx) then topy += part1_top_dy else topy += part2_top_dy end
					if (tlx + i <= blx) then bottomy += part1_bottom_dy else bottomy += part2_bottom_dy end
				end



			elseif(self.rot < 0.5) then
			
			elseif self.rot < 0.75 then
			
			else
			end
		end
	}


	car2 = rotable:new()
	car2.x = 64
	car2.y = 64
	car2.mapw=6
	car2.maph=3
end


function _update()

	if btn(1) then 
		rot = rot - 1/128
	elseif btn(0) then
		rot = rot + 1/128
	end
	rot= rot %1
	car2.rot = rot
end


function _draw()
	cls()
	car2:fill()
	car2:outline()
end