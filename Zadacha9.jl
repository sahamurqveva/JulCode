function spiral!(r::Robot)
    keeper = 1 
    z = 0 
    while z != -1 
        for i in [0, 1]
            schetchik = keeper
            while schetchik != 0
                if ismarker(r)
                    break 
                end 
                move!(r, HorizonSide(i))
                schetchik -= 1
            end
            if ismarker(r)
                break 
            end 
            schetchik = keeper 
        end  
        if ismarker(r)
            break 
        end 
        keeper += 1
        for i in [2, 3]
            schetchik = keeper
            while schetchik != 0
                if ismarker(r)
                    break 
                end 
                move!(r, HorizonSide(i))
                schetchik -= 1
            end
            if ismarker(r)
                break 
            end 
            schetchik = keeper 
        end  
        keeper += 1
    end 
end