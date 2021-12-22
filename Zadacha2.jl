using HorizonSideRobots

while !isborder(r, Ost)
    move!(r, Ost)
end

for i in [0, 1, 2, 3, 4]
    while !isborder(r, HorizonSide(mod(i, 4))) 
        move!(r, HorizonSide(mod(i, 4)))
        if ismarker(r)
            break
        end
        putmarker!(r)
    end 
end