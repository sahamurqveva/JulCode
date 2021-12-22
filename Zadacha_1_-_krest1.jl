using HorizonSideRobots 
function reverse(Side::HorizonSide)
    return HorizonSide((mod(Int(Side)+2, 4)))
end
function main(r::Robot)
    for i in [Nord, West, Sud, Ost]
        while !isborder(r, i)
            move!(r,i)
            putmarker!(r)
        end
        while ismarker(r)
            move!(r, reverse(i))
        end
    end
    putmarker!(r)
end