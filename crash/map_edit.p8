pico-8 cartridge // http://www.pico-8.com
version 32
__lua__
left,right,up,down,fire1,fire2=0,1,2,3,4,5
black,dark_blue,dark_purple,dark_green,brown,dark_gray,light_gray,white,red,orange,yellow,green,blue,indigo,pink,peach=0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
cells_layout, map_layout, menu_layout=0,1,2


function _init()
	poke(0x5f2d, 0x1)
	cell_size = 6
	active_tab = 1
	layout = cell_edit_layout()
	printh(tostr(0b0000000001111111.0101010101111111,true))
	printh(tostr(0b0101010101111111.0101010101111111,true))
end

--Don't want to use sprite space so need to create the icons here.
function c_ico(top, bottom, x, y, col_active, col_inactive, col_hover)
	col_active = col_active or white
	col_inactive = col_inactive or dark_gray
	local inactive, active = 0,1

	return {
		draw = function(self)
			
			local colour = col_inactive
			if (self.state == active) colour = col_active
			if (self.hover and col_hover) colour = col_hover
		end, 
		state = inactive,
		hover = false,
		mouse = function()
			return mx >= x and
				mx < mx + 8 and 
				my >= y and 
				my < y + 8
		end
	}

end

function draw_ico(top, btm, x, y, col)
	local max = 0x8000
	for i =0, 32 do
		if (top & max != 0) then 
			pset(x+ i%8, y+(i\8), col)
		end
		top = top << 1
	end

	for i =0, 32 do
		if (btm & max != 0) then
			pset(x+ i%8, y+(i\8)+4, col)
		end
		btm = btm << 1
	end
end

function _update60()
	mx,my = stat(32), stat(33)
end


--prints the map zoomed
-- zoom is the zoom factor 2 for twice as big
-- 0.5 for half as big
-- mx = the pixel cordiante of the map to start
-- my = the pixel cordiante of the map to start
-- sx = screen offset x
-- sy = screen offset y
function zmap(zoom,mx,my,sx,sy)
	debugtxt = debugtxt.."mapx:"..mx..", mapy:"..my.."\n "
	local z = zoom or 1
	mx= mx or 0
	my= my or 0
	sx= sx or 0
	sy= sy or 0
	for i=0, 127 do
		tline(0,i,127, i, mx/8, (my+i/z)/8, 1/8/z)
	end
end

function cell_edit_layout()
	local data = {
		show_grid = true,
		scroll = 0,
		bg_draw = draw_layout
		
	}
end




function _draw()
	cls()
	draw_layout()
	pointer()

	ico_menu = c_ico(
		0x7e.007e,
		0x7e,
		116, 40)

	ico_map = c_ico(
		0x76.7670,
		0xe6e.6e,
		116, 48)

	ico_tile = c_ico(
		0x66.66,
		0x66.66,
		116, 56)
	
	ico_menu:draw()
	ico_map:draw()
	ico_tile:draw()

	ico_zoom_in = c_ico(
		0x3844.92ba,
		0x9244.3a01,
		100, 40)

	ico_zoom_out = c_ico(
		0x3844.82ba,
		0x8244.3a01,
		100, 56)

		ico_grid =  c_ico(
			0x007f.557f,
			0x557f.557f,
			100, 70)

	ico_zoom_in:draw()
	ico_zoom_out:draw()
	ico_grid:draw()
end

function draw_layout()
	--top
	rectfill(0,0,127,7,red)
	-- Footer
	rectfill(0,121, 127,127,red)
	-- editor
	draw_cell()
	draw_sprites()
	draw_toolbar()
end

function pointer()
	draw_ico(0x80c0.e0f0, 0x4020,
		mx, my, white)
end

function draw_cell()
	local offx = 20
	local offy = 10
	for i=0, cell_size -1 do 
		for j=0, cell_size -1 do 
			local cells = {32,33,48,49}
			local left = offx + 9 * i
			local rght = left + 9
			local top = offy + 9 * j
			local btm = top + 9
			rect(left,top,rght,btm,white)
			spr(rnd(cells), left+1,top+1)
		end 
	end
end

function draw_toolbar()
	rectfill(0, 79, 127, 86, dark_gray)
	for i=0, 3 do
		if (i==active_tab) then
			draw_act_tab(93+i*8,79,i)
		else
			draw_inact_tab(93+i*8,79,i)
		end 
	end
end

function draw_sprites()
	for i=0, 15 do
		for j=0, 3 do
			spr(j*16+i, i*8, 88 + j*8)
		end
	end
end

function draw_act_tab(x,y, tab)
	line(x+3,y,x+7,y,white)
	rectfill(x+2,y+1,x+8,y+7,white)
	line(x+2,y+8,x+8,y+8,light_gray)
	print(tab,x+4,y+1,dark_gray)
end

function draw_inact_tab(x,y, tab)
	line(x+3,y+1,x+7,y+1,light_gray)
	rectfill(x+2,y+2,x+8,y+7,light_gray)
	line(x+2,y+8,x+8,y+8,dark_gray)
	print(tab,x+4,y+2,dark_gray)
end

-->8

-->8

-->8



__gfx__
bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb22444422bbbbbbb22bbbbbbbbb5555bbbbbbbbbbbb5555bb
bbb00bbbbbb00bbbbbb000bbbbb000bbbbb00bbbbbb00bbbbbb00bbbbbb00bbbbbbbbbbbbbbbbbbb24244222bbbbb22e222bbbbbb57d7d5bbbb22bbbb57d7d5b
bb0440bbbb0440bbbb04440bbb04440bbb0440bbbb0440bbbb0440bbbb0440bbbbbbbbbbbbbbbbbb42442224bbb2277e24422bbb57000065bb2722bb57000065
bb0ff0bbbb0420bbbb024f0bbb024f0bb00ff0bbbb0ff00bb00420bbbb04200bbbb2222222221bbb44222244b2277e782424421b5d0000d1117e22115d0000d1
b0df950bb002200bb0d09f0bb0d09f0b0fdf950bb0df95f00fd2250bb0d225f0bb27eeeeeeee21bb42222424b27e78782422241b57111161d77e242d57111161
0fdd55f00fdd55f0b0fd550bb0fd550bb0dd5f0bb0fd550bb0dd5f0bb0fd550bb27e78888882221b22244244b2e8e8e82424241b15d655107e78244215d65510
b040040bb040040bbb04020bbb0040bbbb0400bbbb0040bbbb0400bbbb0040bb27e722222222212122424442b27888e82424241bb15511077ee824422155110b
bb0bb0bbbb0bb0bbbb00b00bbbb000bbbbb0bbbbbbbb0bbbbbb0bbbbbbbb0bbb277888888888821122242422b278e8e82424241bb11100177ee824242111001b
bb000bbbbb000bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb000bbbbb000bbb2782222222222821bbbbbbbbb278e8822222241bb1701517eee8242421d0151b
b04420bbb04420bbbb000bbbbb000bbbbb000bbbbb000bbbb04ff0bbb04ff0bb2888872288888881b3bbbbbbb2e882299222221bb1d01617e8e824242170161b
b042f00bb042f00bb0a940b0b0a9400bb04440bbb04440bbb0000000b000000021117e8211111111bbbbbbbbb2822ff77ff2221bb170151788e8242421d0151b
0d09f0400d09f040b094f007b094f07bb024f000b024f000b0245550b0245550b49411111420021bbbbbb3bbb21ff777777ff11bb1d01617e88e22242170161b
0fd554040fd554040d09f0400d09f40b0d09f0700d09f0700f4000000f400000b44490142220011bbbbbbbbbbb2f72277227f1bbb1111117e8e112222111111b
b0224200b02242000fd5540b0fd520bb0fd5570b0fd5570b000550bb000550bbb49490142422221bbbbbbbbbbb29724f900f91bbb57d7d57ee122122257d7d5b
0224440b0224440bb04020bbb0040bbbb04020bbb00400bbb04020bbbb040bbbb22290141111111bb3333b3bbb29724f999991bb570000651111111157000065
0214040b22004040b00b0bbbbb000bbbb00b0bbbbb000bbbb00b00bbbb000bbbbbbb2222bbbbbbbb32223333bb114224111111bb5d0000d17d7d7d7d5d0000d1
08200bbb08200bbbb070bbbbb070bbbbbb0e0bbbbb0e0bbbbbbbbbbbbbbbbbbbb222222bbbbbbbb3242444423bbbbbbbbbbbbbbb571111610000000057111161
b066d0bbb066d0bbb07000bbb07000bbb08000bbb08000bbbb000b0bbb000b0b15444451bbbbbbb3222242223abbbb3bbbbbbbbb15d655101111111115d65510
b065000bb065000bb070440bb070440bbb066d0bbb066d0bb0444040b044404016999961b3bbbb33423232323bbbbbbbbbbbbbbbb1551107565656565155110b
0706d0400706d040b0602f0bb0602f0bb0065000b0065000b024f002b024f00216944961bbbbb3322211222243bbbbbbbbbbbbbbb51100166dd77d555111001b
0dd004040dd0040404449f0b04449f0b0d506d070d506d070d0990020d09900215466451bbbbb3324343434343bbbbbb24442221b567d517d671051d516dd11b
b066d600b066d600b0f0dd0bb0f0dd0b0d5055700d5055700fd550020fd550021116d000bbbbbb324444444443abbbbb29994441b57d5d1665710d15517d151b
0224dd0b0224dd0bbb04020bbb0040bbb0060d0bb000600bb0402040b004004015221151bbb3bb323232323443abbbbb24222221b5d6d51555d1051111d6d11b
0214040b22004040bb00000bbbb000bbbb00b0bbbbb000bbb00b0b0bbb000b0b15211151bbbbbbb3222221123abb3bbb29444441bb1111bbb111111bbb1111bb
bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb222222b24444442334444332ab44ab222222221bbbb33bbb7bb7bbbbb7bbbbb
bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb0000bbbb0000bbbbbbbbbbbbbbbb1699996124b4b4b2ab3333abab33b31124444441bb33aa1bbb373bbbb7f7bb3b
bbbbb00bbbbbb00bbbbb02bbbbbb02bbb000e44eb000e44ebbb00000bbb000001546645142323232bbaabbbbb3123b3322222221b3a33b31bbb3bbebb373bbbb
bb000770bb000770b0b082bbb0b082bb044404200444042000b04a4200b04a42150650512b1b2b2bbbbbbbbb3ab3b311000000003abb3331bbbbbeaebb3bbcbb
b0776990b07769900200490b0200490b044404200444042009000940090009401000000143434343b3bbbbbb41313ab1122222203b313111bb7bbbebbbbbcacb
b0776990b0776990044420bb044420bb0422200b0422200bb0a9400bb0a9400011100000b4b4b4b4bbbbbbbba3b3bb332421124113130310b7f7bb3bb7bbbcbb
b076600bb076600bb04220bbb04220bb04ee442b04ee442bb094924b094492401522115132323234bbbbbb3b3313133124200241b1103103b373bbbbbb3bb3bb
b09090bb0920290bbb090bbbb09040bb0400402b0240042bb090924bb00009241521115122222112bbbbbbbb2121111211100111bb333333bb3bbbbbbbbbbbbb
ccccccccc76cc7cccccccc67ccccccccbbbbbbbbbbbbbbb555bbbb5555bbbbbbb31f95bbbbbbbbbbb31f93bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb1bbbbbbbbb
cccccccc6cccd5655555dccccc6ccc7cb3b3bb3bb3bbbb57ab3b55abb15bbb3b331f933b33333333b31f93bbbbbbb3333333bbbbb3bbbb100bb0b16003bbbbbb
ccccccccccddf35fffff955555c76cc6bb3bbbbbbbbbb5ab13357b313bb1bbbb341f954311111111b31f93bbbb3b311111133bbbbbb0017650170765503033bb
ccccccccc5ff33333333399ff5ccc5ccbbbbbbbbbbb55b3b311a3313b1311bbb301f9503fffffff9b31ff3bbb3b31ffffff333bbbb065065107650551006033b
ccccccccc5f33b3b333333333355590cbbbb3b3bbb5ab51331b131b3b13131bbf022220f9f99f999b31f93bbbb319f999f9f33bbb10551011105510110075033
cccccccccc53b3bbb3333b33333ff90dbbbbb3bbb573b111b31311113313110b0244440033333333b31f93bbb31ff93339ff93bb306011001060110000751103
cccccccc6c533bbb3bbbb3bbb333ff0db3bbbbbb5ab3bb31313113b131b11310d022220dbbbbbbbbb31ff3bbb31f933b319f93bb305000030050003300550033
cccccccccdf33bbbbb3bbbbb3b333f0dbbbbbbbb5b31331111b3111111331110c244440cbbbbbbbbb31f93bbb31f93bbb31f93bbb00033bb3000333b330033bb
ccccccccc5f333bbbbbbbbbbbb33395dbbbbbbbb5ab31b31b1311b31b1311310c0222207bbbbbbbbb31f93bbb31f93bb331ff3bbbbbbbbbbbbbbbbbbbbbbbbbb
ccccc6cc659333bbbbbbbbbbbb3390dcbb3bbbbb5b31b3313111b311311131105244440c33333333331f93b3b31f9333331f93bbbbb3bb11b3b1bb3bbbb0b0bb
cc76cccc75933b3bbbbbbbbbb3b3f0d6bbbbbbbbb1b3331313b311311bb31110f02222051111111111ff93bbb31fff1111ff93bbbbbbb1750b170bbbb317050b
ccccccccc5f333bbbbbbbbbbbb33f0d7bbbbbbbbbb1b3b313111b313b131310b3244440fffffffffff9ff3bbbb33fffffff93bbbb3bb1765107510bb3176500b
ccccc7ccc5f33b3bbbbbbbbbb33330dcbbbbbb3bbb513313b13131b3b13110bb302222039f99f999999f93bbbbb339f99f93bbbbbbb106511665010b3165510b
ccccccccc75f33bbbbbbbbbbbb333f5dbbbbbbbbb5abb331331311113313110b34000043339f9933319f93b3bbbb3333333bbbbbbb1760151010500b17151103
c7ccccccc6df33bbbbbbbbbb3b333f0db3bbbbbb57b3333131b11b3131b1110b30199103b31ff3bbb31ff3bbbbbbbbbbbbbbbbbbb17755050175050b31707503
cccccccccdf33bbbbbbbbbbbbb333f0dbbbbbbbb5a313113113311111133110b3319933bb31f93bbb31f93bbbbbbbbbbbbbbbbbb177555101761011017650103
ccccccccc5f333bbbbbbbbbbb3b3f0dcbbbbbbbb5bb33b31b1311b31b131100bbbbb3bbbb31f93bbb31f93bbb31f93bbbbbbbbbb165070101507605016651003
cc55cccc65ff3b3bbbbb3b3b3b3390d6bbbbb3bb51bbb1313111bb313111110bb94bb94b331f9333b31f933b11ff933bbbb00bbb050751065070651031101650
c550ccccc54ff333b3b33333339990dcbb3bb3bbb41b33111bb311111310101b2441244111f99911b31f9f11fff99f11bb0760bbb006507607610003b3170510
75006ccccc00f3333333333339000dccbbbbbbbbb3113313113133101110043bb22bb22bffffffffb31fffff999fffffb1065103bb0007657651103331765010
c776cccc6ccd0ffff333399ff900dcc6bbbbbbbbbbb311010000110000013bbb242124219f99f999b31f999933ff999930601103bbbb3001555510333165510b
ccccc50cc7ccd0000fff90000090dc7cb3bbbbbbb3bb0000411200004112bbbbb42bb42b33333333b31f9933b31f993330500033bbbb07500111033b17151103
ccc75506cccccdddd0055dddd000dc6cb3bbbb3bbbbb4123bbb14123bbbbbb3bbbbbbbbbbbbbbbbbb31ff33bb31ff33bb00033bbb3bbb00b300033bb31707503
cccc776cccc6cc6ccddddccccdddc6ccbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb3bbbbbbbb3bbb3b31f93bbb31f93bbbbbbbbbbbbbbbbbbb3333bbb17650103
b3bbbbbbbbbbbbbbbb33ff0fc5f3bbbbbbbbbbbbbb5555bbb33020202020203bbbb21bbbbbbbbbbbbbbbbbbbbbbbbbbbb31f93bbbbb33bbb1511015016651003
bbb33bbbbbb3bbbbbbb3f90c5f33bbbbb244442bb57b315b3332222222222033bbbf4bbb333bbbbbbbbbb333bb3bfbbbb31ff3bbbb3cccbb1155501031101650
bb3bb33bb3bbbbbbbb33f0d5f33b3bbbb499492b5ab131a11112424242424011b3b44bbb1113b3bbbb3b3111bb3fb3bbb31f93b3b3cc66cb15676500b3170510
b3b333333b3bb3bbbb33f059333bbbbbb244442b1b3313b3f9f24242424240ffbbb21bbbffff9fbbbbf9ffffb31ffbb3bb3f93bbb3cc66cb17111d0031761010
b3b333ff33bbbbbbb3b3ffff33b3bbbbb222222b11311b3099f2121212121099bbb21bbb999ffbfbbfbff999bb3f93bbb31ffbb3b33cccbb161005003165110b
bb333ff993b3bbbbbbb33ff3bb3bbb3bbbb42bbb301101033330101010101033bbbf4bbb33b3bfbbbbfb3b33b31f93b3bb3fb3bb3ccbb3bb1d100d0317151103
b3b33f90033bb3bbbb3b3333bbbbbbbbbbb42bbbb300002bbb3030d0c050313bbbb44b3bbbbbbbbbbbbbbbbbb31ff3bbbb3bfbbb3c6b3c6b1510050330300033
bb33390dd5933bbbbbb3bbbbbbbbbbbbbbbbbbbbbb4121bbbb33335dcc533bbbbbb21bbbb3bb3bbbbbb3bb3bb31f93bbbbbbbbbbb3bbb3bbb333333bb333333b
5555555555555555555555505555555555555550555555555610005055555555bbbbbbbbbbbbbbbbb00b000bb00b000bbbbbbbbbbbbbbbbbbbbbbbbbbbb1113b
5766777057667766776677705766776677667770776677667710007057667770bb110bbbbb110bbb042044f0042044f0bbbbbbbbbbbbbb3bbbbbbbbbb33aabbb
5711116057111111111111605711111111111160111111111110006057111160b17760b0b17760b00220499002204990bbb3bbbbbbbbbbbbbbbbbbbbababbbbb
5711116057111111111111605711111111111160111111111110006057111160b1775007b1775007b0204420b0204420bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
561000705610000000000070561000000000007000000000000000705610007022206070b2226070b024f990b024f990bbbbbbbbbb1111bbbbbbbbbbbb333bbb
56100070561000000000007056100000000000700000000000000070561000702427000bb242000bb0f02220b0f0220bbbbbbbbb1177aa113bbbbbbbb33240bb
5710006057776677667766705710007767100060661000776710006057776670020060bbb0200bbbbb00f090bb0b0f0bbbbbbb31a7aabaab133bbbbb324220bb
5710006011111111111111105710006017100060571000601710006011111110b10b00bbbb000bbbbbb00b00bbbb000bbbbbb31ababbabba3133bbbbb33330bb
5610007055555555561000705610007556100070561000755610007056100070bbbbbbbbbbbbbb66666bbbb666bbbbbbbbbb31aa23abbbb331033bbbb3111bbb
5610007077667766561000705610007677100070561000767710007677100076bbbbb67bbb6bb677777666677766bb76b3bb31ab23abbbb333103bbbbbbaa33b
5710006011111111571000605710001111100060571000111110001111100011bbbb677db6766777777777777777db6bbbbb317a13aabb33b3303b3bbbbbbaba
5710006011111111571000605710001111100060571000111110001111100011bbbbb6dbbb6677777777777776777dbbbbb317ab13abbb33b3303bbbbbbbbbbb
5610007000000000561000705610000000000070561000000000000000000000bb6bbbbbbbb6777777777767777776dbbbb31aba137abb34b31433bbbbb333bb
5610007000000000561000705610000000000070561000000000000000000000b677dbbbb667777776677777776776dbbbb321ab37abbb34330433bbbb04233b
5777667066776677571000605777667766776670571000776677667766100077bb6dbb7b67777767777766777667766dbbb321ab3abbbb32310233bbbb022423
1111111011111111571000601111111111111110571000611111111117100061bbbbbbbb67777777777777777777776dbbb3491abbbbb333310233bbbb03333b
d5ddd5ddd5ddd5dd15ddd5d015ddd5ddd5ddd5d0bbbbbbbbbb1110bbbb2222bbbbbbbbbb67777777777777767777776dbbbb344233bbb333324333bbbbbbbbbb
5555555555555555155555501555555555555550b222bbbbbb1420bbb277662bbbb66b6b67777777776777777767776dbbbb32424233329242233bbbbbbabbbb
ddd5ddd5ddd5ddd51dd5ddd01dd5ddd5ddd5ddd0277a2220bb16d0bb27444461bb67767667777677766776677667766dbbbb33229299424242333bbbb3ababb3
55555555555555551555555015555555555555502709aaa0b1676d0b2747d261b67777dbb677777777777777777776dbbbbbb333229442222333bbbb3ababb31
00000000000000000000000000000000000000002a99094028ee8820274d12d1b67676dbb677776777777777777766dbb3bbbb3312222211333bbbbb3aaab312
0000000033333333000000000000000000000000b000000028888820264222d1b677766db677766777767677776766dbbbbbbb333221113333bbb3bbaababbb1
01011011b3b3b3b3010110110101101101011011bbbbbbbbb022220bb166dd1bbbdd66dbb677777777667777777766dbbbbbbbb3333333333bbbbbbbabbbbbbb
111111113b3b3b3b111111111111111111111111bbbbbbbbbb0000bbbb1111bbbbbbddbbb677777767777776777776dbbbbbbbbbb33333bbbbbbbbbbbbbbbbbb
55151551bbbbbbbb1515155150000005155555d0b44444bbbbbbbb1bbbbbbbbb7777777667776777777777777777776dbbbbbbbbbbbbbbbbbbbb321a31033bbb
51151511bbbbbbbb111115110999444015122150479aa94bbbbbb170bb1001bb76777777d7777777777667777677666db3bbbb3333bbbb3bb3bb31aab3033bbb
11011110bbbbbbbb00051000922222241d0440d044a797a0bbbb176011600d1177777677bdd677677777776766766ddbbbbbb3929233bbbbbbbb1aabbb311bbb
15155515bbbbbbbb3301103322424221150f9050b4994990bbb1760b5717d16577777777bbbd6777766777777776dbbbbbb3329292423bbbbbb1aabbbbbaa1bb
151510150000b000bbb000bb46124221000f9000b447a40bb02760bb1dd11dd177677777bbbbd677777776677766db76bb334242224223bbb117abbbbbbbb31b
0111111155500055bbbbbbbb410222211109901147a994a0b0420bbbb1766d1b77777767b776d66777666666766dbb6bb3324222112221ab1aaababbbbbbbb31
5155155151155151bbbbbbbb222222211109401149900a9004000bbbb1dddd1b77767777b66bbd666666dddd66d76bbb33421233331122abababbbbbbb3bbbba
1111011011151111bbbbbbbb1111111111044011b00bb00b00bbbbbbb111111b67777776bbbbbbddddddbbbbddb6bbbb3321333bb333123bbbbbbbbbbbbbbbbb
__map__
214748434443444344434443444344434443444344434443494a212021214748434443444344434443444344434443444344494a21202020202020202020202020202020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
565758646564656465646564646565646564656465646564595a5b3031565758646564656465646564656465646564656465595a5b202020202020202020202020202021000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
666775747574757475747574747575747574757475747574756a6b2021666764747574757475747574757475747574757475756a6b202020202020202020202020202020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
4564656465646564646564656564656465646564656465646564453031456465756564656465646564656465646564656465646545202020202020202020202020202030000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5574757475747574747574757574757475747574757475747574552021557475747574757464656465646564656465757464657555202020202020202020202020202031000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
4564656465646564656465646564656465646564656465646564452021457475646564657474757475747574757475646574750e0f202020202020202020202020202021000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
45747574757475747574757475747574757475747574757475745530315564657475746465684344434443444344697464651d1e1f202020202020202020202020202020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
55646564656465684344434443444344434443446964656465647843447974646564657475452020202020204748796465752d2e21202020202020202020202020202030000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
4574757475747545202120214041422121414152457475747575746575747474757475747555204041422056575875746465452040414220202020202020202020202020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5564656465646555303130315051525340515262556465646564656465646564656465646545205051525366677564657475552050515253202020202020202020202021000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
4574757475747545404142216061626361525162457475747574757475747574757464657555206061626345646474756464452060616263202020202020202020202020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
55646564656465555051525320717231515252524c4d64646564656465646564656474750e0f202071722055646464646464552020717220202020202020202020202030000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
45747574757475456061626320212021515262625c5d5e7475747574757475747574751d1e1f202020202045646464646464452020202020202020202020202020202031000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
556465640a0b0c55217172213031303161615172216d6e4344434443444344434443442d2e202020202020550a0b0c646464552020202020202020202020202020202021000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
457475741a1b1c784344434443444344434443444344434443444344434443444369202020404142202020451a1b1c656465452020202020202020202020202020202020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
556465642a2b2c646564656465646564656465646564656465646564656465646545202020505152532020552a2b2c757475552020202020202020202020202020202030000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
457475747574757475747574757475747574757475747574757475747574757475494a202060616263202045747564656465452020202020202020202020202020202031000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
556465646564656465646564656465646564656465646564656465646564656465595a4a2020717220202055646574647475552020202020202020202020202020202021000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
45747574757475747574757475747574757475747574757475747574757475747564595a4a2020202047487974646465750e0f2020202020202020202020202020202020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
4c4d656465646564656465646564656465646564656465646564656465646564656465595a5b202056575864657474751d1e1f2020202020202020202020202020202030000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5c5d5e7475747574757475747574757475747574757475747574757464657574757464656a6b202066676474646568442d2e202020202020202020202020202020202031000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
206d6e4344434443444344434443444344434443444344434443446974646564646574646578434479646564657555202020202020202020202020202020202020202021000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2020212020202020202020212020202020202021202020202020204c4d746465646564657564656465646474750e0f204041422020202020202020202020202020202020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2030312020404142202030312020202021203031202040414220205c5d5e74757464747564657564657474751d1e1f205051525320202020202020202020202020202030000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
203031202050515253202020202020303120202020205051525320206d6e43446974646574756474756843442d2e20206061626320202020202020202020202020202031000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
20202020206061626320202020202120202021202020606162632020202020204c4d7464656474750e0f2020202020202071722020202020202020202020202020202021000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
20202020212071722020212120303120203031202020207172202040414220205c5d5e747574751d1e1f2020202020202020202020202020202020202020202020202020000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2020203031202020203031312020202020202020202020202020205051525320206d6e434443442d2e202020202020202020202020202020202020202020202020202030000002000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2020202020202020202020202020212020202120202020202020206061626320202020212020202020202020202020202020202020202020202020202020202020202031000003000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2020202020202020202120202030312020303120202020202120202071722020202030312020202020202020202020202020202020202020202020202020202020202021000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000cacbcccdcecf
2020202020202020303120202020202020202020202020303120202020202020202020202020202020202020202020202020202020202020202020202020202020202020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000dadbdcdddedf
2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202030000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000eaebecedeeef
