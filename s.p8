pico-8 cartridge // http://www.pico-8.com
version 29
__lua__
el={}::a::add(el,{1,rnd()*128,rnd()*128})

for e in all(el) do m,o,f =7,6,e[1] if(f>5)del(el,e)
if(f==1)o=0
if(f==3)m=7
if(e[1]==4)m=0
color(rnd(16))
circ(e[2],e[3],1,o)pset(e[2],e[3],m)e[1]=e[1]+1
e[2]+=sin(t)*20
e[3]+=cos(t())
end flip()flip() ::e:: goto a

