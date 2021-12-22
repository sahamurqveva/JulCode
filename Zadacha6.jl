mvs = []
rectangle = [Ost, Nord, West, Sud]
cardinal_directions = [Nord, West, Sud, Ost]

function inverse(Side::HorizonSide)
    return HorizonSide((mod(Int(Side)+2, 4)))
end

function MoveIfPossible(r::Robot, side::HorizonSide)
    if !isborder(r, side)
        move!(r, side)
    end
end

function snake_dif!(r::Robot)
    while !isborder(r, Nord) || !isborder(r, Ost)
        while !isborder(r, Ost)
            move!(r, Ost)
            if isborder(r, Nord)
                break
            end
        end
        if !isborder(r, Nord)
            move!(r, Nord)
        else 
            break
        end
        while !isborder(r, West)
            move!(r, West)
            if isborder(r, Nord)
                break
            end
        end
        if !isborder(r, Nord)
            move!(r, Nord)
        else 
            break 
        end
    end  
end

function go_to_corner!(r::Robot, mvs::AbstractArray)
    while isborder(r, Sud) == false || isborder(r, West) == false
        moveIfPossible!(r, mvs, Sud)
        moveIfPossible!(r, mvs, West)
    end
end

function moveIfPossible!(r::Robot, mvs::AbstractArray, side::HorizonSide)
    if !isborder(r, side)
        move!(r, side)
        push!(mvs, side)
    end
end

function return_back!(r::Robot, mvs::AbstractArray)
    while length(mvs) > 0
        last_move = pop!(mvs)
        move!(r, inverse(last_move))
    end  
end

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

function main(r::Robot)
    go_to_corner!(r, mvs)
    snake_dif!(r)
    while isborder(r, Nord)
        move!(r, West)
    end 
    move!(r, Ost)
    for l in [1, 2, 3, 4]    
        while isborder(r, cardinal_directions[l])
            putmarker!(r)
            move!(r, rectangle[l])
        end
        move!(r, cardinal_directions[l])
    end
    go_to_corner_Sud_West!(r)
    return_back!(r, mvs)
end