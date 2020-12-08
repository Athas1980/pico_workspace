r=0
a = 0.001
function _update60()
p=1440f=64/p
r+=a
end

function _draw()
cls()
for i=0, p,0.25 do pset(cos(i*r/360)*i*f+64,sin(i*r/360)*i*f+64,i%15+1) end
print(r,0,0,1)
end
