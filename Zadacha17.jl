function main!(r)
    counters = move_West_Nord(r)         
    move_forward!(r, Sud)                 
    putmarker!(r)
    row_length = move_forward!(r, Ost)   
    move!(r, Nord)
    snake!(r, row_length)
    move_West_Nord(r)
    go_nachalo!(r, counters)
end



function snake!(r, counter)      
    direction = 1
    counter+=1
    counter1 = counter-1
    while counter1!=0 
        i = 0
        if direction == 1                  
            while i != counter - counter1
                if !isborder(r, HorizonSide(1))
                    move!(r, HorizonSide(1))
                    i+=1
                else
                    i += obhod!(r, direction)
                    i+=1
                end
            end
            putmarker!(r)
        else                                
            putmarker!(r)
        end
        while i != counter-1               
            if !isborder(r, HorizonSide(direction))
                move!(r, HorizonSide(direction))
                i += 1
                if direction==1
                    putmarker!(r)
                end
            else   
                i += obhod!(r, direction)
                i+=1
                if i<=counter1+1
                    putmarker!(r)
                end
            end
            if i<counter1   
                putmarker!(r)
            end
        end
        if !isborder(r,Nord)                     
            move!(r, Nord)
        else                                     
            return 0                            
        end
        direction = (direction+2)%4
        counter1 -= 1
    end    
end



function move_forward!(r, side)      
    c = 0
    while !isborder(r, side)
        move!(r, side)
        c+=1
        if side==Ost                  
            putmarker!(r)
        end
    end
    return c
end


function obhod!(r, side)
    counter = 0
    counter1 = 0
    while isborder(r, HorizonSide(side))
        move!(r, Nord)
        counter+=1
    end
    move!(r, HorizonSide(side))
    while isborder(r, Sud)
        move!(r, HorizonSide(side))
        counter1 += 1
    end
    for i in 0:counter-1
        move!(r, Sud)
    end
    return(counter1)
end




function move_West_Nord(r)           # идем в левый верхний угол
    counters = []
    while !(isborder(r,Nord) && isborder(r,West))
        counter_N = 0
        while !isborder(r,Nord)
            move!(r, Nord)
            counter_N+=1
        end
        pushfirst!(counters, counter_N)
        counter_W = 0
        while !isborder(r,West)
            move!(r, West)
            counter_W+=1
        end
        pushfirst!(counters, counter_W)
    end     
    return counters
end


function go_nachalo!(r, counters)   # возвращаемся в начало
    for i in 1:size(counters, 1)
        if i%2==0
            for j in 0:counters[i]-1
                move!(r, Sud)
            end

        end
        if i%2==1
            for j in 0:counters[i]-1
                move!(r, Ost)
            end
        end
    end
end
