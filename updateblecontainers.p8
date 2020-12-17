pico-8 cartridge // http://www.pico-8.com
version 16
__lua__

function _init()
    item1 = make_object1_instance(1)
    item2 = make_object1_instance(2)
    item3 = make_object1_instance(3)

    object1 ={item1, item2, item3} -- not used in this example just to show you can have seperate sequences
    item4 = make_object2_instance(100)
    item5 = make_object2_instance(101)

    object2 = {item4, item5} -- not used in this example just to show you can have seperate sequences
    updatables ={item1, item2, item3, item4, item5, make_object2_instance(1000)}

end

function _update()
    doupdate = false
    if (btnp(4)) doupdate = true
end

function _draw()
    if (not doupdate) return
    for updatable in all(updatables) do
        updatable:update()
        updatable:draw()
    end    
end



function make_object1_instance(_number) 
    return {
      num=_number,
      update=function(self)
        self.num+=1
      end,
      draw=function(self)
        print(self.num)
      end
    }
end

function make_object2_instance(_number) 
    return {
      num=_number,
      update=function(self)
        self.num-=1
      end,
      draw=function(self)
        print(self.num)
      end
    }
end