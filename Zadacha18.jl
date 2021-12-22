function main!(r)
    counters = move_to_corner!(r) 
    println(counters)
    mark_each_corner!(r)
    nachalo!(r, counters)
end


function move_to_corner!(r)       
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

function mark_each_corner!(r) 
    for i in 1:4
        while !isborder(r, HorizonSide(4-i))
            move!(r, HorizonSide(4-i))
        end
        putmarker!(r)
    end
end


function nachalo!(r, counters) 
    println(size(counters))
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
