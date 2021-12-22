mvs = []

function reverse(Side::HorizonSide)
    return HorizonSide((mod(Int(Side)+2, 4)))
end

function main(r::Robot) 
    for i in [0, 1, 2, 3]
        while !isborder(r, HorizonSide(i)) && !isborder(r, HorizonSide(mod(i+1,4)))
            move!(r, HorizonSide(i))
            push!(mvs, HorizonSide(i))
            move!(r, HorizonSide(mod(i+1,4)))
            putmarker!(r)       
            push!(mvs, HorizonSide(mod(i+1,4)))
        end
        while length(mvs) != 0 
            move!(r, reverse(pop!(mvs)))
        end
    end
    putmarker!(r)
end