using HorizonSideRobots

function vnutri(r::Robot)
    while !isborder(r,  Sud) 
        move!(r, Sud)
    end

    while !isborder(r, West)
        move!(r, West)
    end
    
    while !ismarker(r)
        while !isborder(r, Ost)
            putmarker!(r)
            move!(r, Ost)
        end
        putmarker!(r)
        while !isborder(r, West)
            move!(r, West)
        end
        if !isborder(r, Nord)
            move!(r, Nord)
        else 
            break
        end
    end   
end