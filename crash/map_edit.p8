pico-8 cartridge // http://www.pico-8.com
version 29
__lua__
function _init()
end

function _update60()
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
	palt(5, false)
	palt(0, false)
	zoom = zoom or 1
	mx= mx or 0
	my= my or 0
	sx= sx or 0
	sy= sy or 0
		for i=0, 127 do
			tline(0,i,127, i, mx/8, (my+i/zoom)/8, 1/8/zoom)
		end
	end


function _draw()
end



-->8

-->8

-->8
function create_camera(sx, sy, sw, sh)
	return{
		sx= sx,
		sy= sy, 
		sw= sw,
		sh= sh,
		posx = 0,
		posy = 0,
		zoom = 1.25,

		oldtargetoffx=0,
		oldtargetoffy=0,
		targetoffx = 0,
		targetoffy = 0,

		targetzoom = 1.25,
		follow= function(self, car)
			self.oldtargetoffx = self.targetoffx
			self.oldtargetoffy = self.targetoffy
			self.carx = car.x
			self.cary = car.y
			--FIXME use screen width and height
			self.targetoffx, self.targetoffy= 63/self.zoom -32*cos(car.rot)/self.zoom, 63/self.zoom-32*sin(car.rot)/self.zoom
			self.targetzoom = 1.25 - #player.velocity/8
		end,
		update = function(self)
			self.zoom = ease(self.zoom, self.targetzoom)
			local actualoffx = x
			self.posx = self.carx - limit(self.oldtargetoffx, self.targetoffx)
			self.posy = self.cary - limit(self.oldtargetoffy, self.targetoffy)
		end,
	}
end

function ease(cur, tar)
	return cur+(tar-cur)/20
	--return tar
end

function limit(cur, tar)
	return cur + mid(-1, tar-cur, 1)
end
__gfx__
000000000000000000000000000000000000000000000000000000000000000000000000000000005555555555e55555555555e50000000055e5555506666650
00000000000000000000000000000000000000000000000000000000000000000000000000000000e555551555555e5555555555000000005555555056676503
00700700000000000000000000000000000000000000000000000000000000000000000000000000555511111155555555555555000000005555550566666603
0007700000000000000000000000000000000000000000000000000000000000000000000000000055511c111115555555555555000000005555550666765033
000770000000000000000000000000000000000000000000000000000000000000000000000000005511c111111111111555e55500000000e55e505676665033
00700700000000000000000000000000000000000000000000000000000000000000000000000000511c111111cccccc11155555000000005555056676550333
00000000000000000000000000000000000000000000000000000000000000000000000000000000511111111c111111c1115555000000005555066666660333
00000000000000000000000000000000000000000000000000000000000000000000000000000000511c11111111111111115555000000005550565676503333
00000000000000000000000000000000000000000000000000000000000000000000000000000000511111111111111111111555e5555e555550506676503333
00000000000000000000000000000000000000000000000000000000000000000000000000000000511111111111111111111555555555555506650665033333
0000000000000000000000000000000000000000000000000000000000000000000000000000000051111111111111111111155555e555555066665065033333
000000000000000000000000000000000000000000000000000000000000000000000000000000005511111111111111111155e5555555500667666565033333
00000000000000000000000000000000000000000000000000000000000000000000000000000000e5511111111111cc11115555555555066766666550333333
00000000000000000000000000000000000000000000000000000000000000000000000000000000555511111111c111111115555e5550606765665003333333
000000000000000000000000000000000000000000000000000000000000000000000000000000005555111111c111111111c155555506066667660333333333
000000000000000000000000000000000000000000000000000000000000000000000000000000005551111111c11111111c1155555066666567603333333333
3bb333333b3333330000000000000000000000000000000000000000000000000000000000000000e5511111111111111c111115006666676650333300000000
bb333333bb33333300000000000000000000000000000000000000000000000000000000000000005511c1111111111111111115066666676603333300000000
b333333333353b330000000000000000000000000000000000000000000000000000000000000000511c11111c11111111111115066666666033333300000000
3333b3333353bb3300000000000000000000000000000000000000000000000000000000000000005511c1111111111111111115066676660333333300000000
333bb533335bb33300000000000000000000000000000000000000000000000000000000000000005551111111111111c1111155056660003333333300000000
33bb5333353333b30000000000000000000000000000000000000000000000000000000000000000555515111111111111111155000005033333333300000000
3335333333333bb500000000000000000000000000000000000000000000000000000000000000005555555111111111111115e5505550333333333300000000
333333333333335300000000000000000000000000000000000000000000000000000000000000005e5555555555511111155555000003333333333300000000
33333333333333330000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
33b33333333bb3330000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3b33333333bb33330000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3b33b333333333330000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
333b3355333333530000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
33bb35533bbb35530000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
333333333b3335330000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
33333333333333330000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3b333353333533333333333300000000000000000655550000000000333333333330000000000333333333330000000005666660555e55550000000000000000
bb3335333353333333333353057666666666676505666050000000003333333333066666506660333333333300000000305676660555555e0000000000000000
b33b3333333333ab33a3353356666666666767660577666000000000333333333066566656666603333333330000000030666666505555550000000000000000
33bb33333333bb3a3a3b53335666776656676666056666500000000033333333067665665666676033333333000000003305676660555e550000000000000000
33b3333aba33b3a3b3b33b3355566657565665660666776000000000333333306667666656667666033333330000000033056667650555550000000000000000
33333aa33bb5bbabbbbbb3b300000000000000000566675000000000333333066666660000666666603333330000000033305567665055550000000000000000
3553a33bbb4545b5bbb3bb5356566565566566550566665000000000333330667655605555066667660333330000000033306666666055550000000000000000
5533abbbb54b5bbbba3535b500000000000000000567665000000000333305667666650000506667665033330000000033330567656505550000000000000000
33333bb3a5bab3bb3bbb53b544533335000000000567665033333333330676566666005555000666656760333333333333330567660505555e55555500000000
333333bbab5bb35bab353535b543335300000000056666503333333330667666665055555555000666676603333333333333305660566055555e555500000000
333a33bb4bb5b5b3b3ab3535545353330000000005666750333333330566567666055555e5555550676566500333333333333056056666055555555500000000
353b5b3b4bb55b5b5553b3b53533b3330000000006667760333333305666667600555e5555555550676666655033333333333306566676600555e55500000000
533ab3b3b5bb5353b55b1115b1554433000000000566665033333306566676600555555555555555066766656503333333333330566666766055555500000000
333a3b3b3bb55b5b555bb1511115343300000000057766603333305605666605555555e55e55555550666650650333333333333305665676060555e500000000
3333babb535b3b3555baab5151b4553300000000056660503333305660566055555e555555555555550665066503333333333333306676666060555500000000
33333335b5ba5554553bb5b511514533000000000655550033330567660505555555555555555555555050667650333333333333330676566666055500000000
3333335b35ab5b544b3555bbb111b533555555555555555533330567656505555555500000055555555056567650333300000000333305667666660000000000
333333335bb555b553b3bb1515b5133355555555555e555533306666666055555555065005605555555506666666033300000000333330667666666000000000
33b333333b53555b311b5bb3141b333555e555555555555533305567665055555500676556760055555505667655033300000000333333066666666000000000
3bb333b3bab53b15b151bbb33313333555555555555555553305666765055e555076676556766705555550567666503300000000333333306667666000000000
3b3333bb3b5353511115333b13113b33555555555555555533056766605555550667666556667660e55555066676503300000000333333330006665000000000
333533babbb335311153bb1113133bb355555e55e555555530666666505e55e50667665005667660555555056666660300000000333333333050000000000000
335333b3a35335b53b3b3b15111333b3555555555555555530567665055555550766656556566670555555505667650300000000333333333305550500000000
3333333b33333bb3b3b14453b353333355555555555555550566666555555555055565000055655055555e555666665000000000333333333330000000000000
000000003333bb53bb31111500000000555555555555555500000000000000000600000000000060000000000000000000000000000000000000000000000000
000000003333bb13b114bb13000000005555e5555555555500000000000000000665556556556660000000000000000000000000000000000000000000000000
000000003533555111113415000000005555555555555e5500000000000000000676666556666760000000000000000000000000000000000000000000000000
0000000053333335513111330000000055e555555555555500000000000000000676656556566760000000000000000000000000000000000000000000000000
0000000033b333b333333333000000005555555555e5555500000000000000000056666556666505000000000000000000000000000000000000000000000000
000000003bb33bb33353353300000000555555e55555555500000000000000005066555005556605000000000000000000000000000000000000000000000000
000000003b333b333355353300000000555555555555555500000000000000005500666556660055000000000000000000000000000000000000000000000000
00000000333333333333333300000000555555555555555500000000000000005555000000005555000000000000000000000000000000000000000000000000
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333


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
20202020212071722020212120303120203031202020207172202040414220205c5d5e747574751d1e1f2020202020202020202020202020202020202020202020202020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2020203031202020203031312020202020202020202020202020205051525320206d6e434443442d2e202020202020202020202020202020202020202020202020202030000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2020202020202020202020202020212020202120202020202020206061626320202020212020202020202020202020202020202020202020202020202020202020202031000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2020202020202020202120202030312020303120202020202120202071722020202030312020202020202020202020202020202020202020202020202020202020202021000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000cacbcccdcecf
2020202020202020303120202020202020202020202020303120202020202020202020202020202020202020202020202020202020202020202020202020202020202020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000dadbdcdddedf
2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202030000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000eaebecedeeef

