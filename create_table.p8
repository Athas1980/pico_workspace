pico-8 cartridge // http://www.pico-8.com
version 16
__lua__


function _init()

    t1 = "x=54,y=128,h=10,w=5"

end

function _draw()
    cls()
    tab = create_table(t1)
    print(tab.x)
    print(tab.y)
    print(tab.h)
    print(tab.w)
end

function create_table(str)
    local o = {}
    for e in all(split(str)) do
        local key, value = unpack(split(e, "="))
        o[key]=value
    end
    return o
end