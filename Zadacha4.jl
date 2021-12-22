using HorizonSideRobots

mvs = []
z = []

function go_to_corner_Sud_West!(r::Robot)
    while !isborder(r, Sud) || !isborder(r, West)
        while !isborder(r, Sud)
            move!(r, Sud)
        end
        while !isborder(r, West)
            move!(r, West)
        end
    end
end 

function sledstroki!(r::Robot)
    while mvs != []
        putmarker!(r)
        pop!(mvs)
        move!(r, Ost)   
    end
    while !isborder(r, West)
        push!(mvs, Ost)
        move!(r, West)
    end
end

function pervaiastroka!(r::Robot)
    while !isborder(r, Ost)
        putmarker!(r)
        push!(mvs, Ost)
        push!(z, Ost)
        move!(r, Ost)
    end 
    putmarker!(r)
    push!(mvs, Ost)
    push!(z, Ost)
    go_to_corner_Sud_West!(r)  
end

function main(r::Robot)
    go_to_corner_Sud_West!(r)
    pervaiastroka!(r)
    if !isborder(r, Nord)
        move!(r, Nord)
    end
    while mvs != 0
        pop!(mvs)
        sledstroki!(r)
        if !isborder(r, Nord)
            move!(r, Nord)
        else
            break
        end
    end
end