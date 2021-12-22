function putmarker(r,side)
    while isborder(r,side) == false
        move!(r,side)
        putmarker!(r)
    end
end
function moverobot(r,side)
    while ismarker(r) == true
        move!(r,side)
    end
end
function reverse(side)
    for i=0:3
        if side == HorizonSide(i)
            return HorizonSide(mod(i+2, 4))
        end
    end
end
function krest(r)
    for side in (HorizonSide(i) for i=0:3)
        putmarker(r,side) #функция передвигает и ставит марки
        moverobot(r,reverse(side)) #функция перемещает в первоначальное положение, revers делает сторону противоположной
    end
    putmarker!(r)
end    

krest(r)