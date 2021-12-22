function inverse(Side::HorizonSide)
    return HorizonSide((mod(Int(Side)+2, 4)))
end

function movements!(r::Robot, side::HorizonSide, n::Int)
    z = n 
    while z != 0 
        move!(r, side) 
        z -= 1 
    end
end

function shut!(r::Robot)
    n=0 # число шагов от начального положения
    while isborder(r,Nord)
        n += 1
        movements!(r, Ost, n)
        if !isborder(r, Nord)
            break 
        end
        movements!(r, West, n*2)
        if !isborder(r, Nord)
            break 
        end
        movements!(r, Ost, n)
    end
end