import HorizonSideRobots: move!
import HorizonSideRobots: isborder
import HorizonSideRobots: putmarker!
import HorizonSideRobots: temperature
import HorizonSideRobots: ismarker

HS = [Nord, Ost, Sud, West]
mvs = []    

mutable struct Coord
    x::Int
    y::Int
end    

Coord() = Coord(0,0)

struct XYRobot
    robot::Robot
    coord::Coord
    XYRobot(r,(x,y))=new(r,Coord(x,y)) 
    XYRobot(r)=new(r,Coord())
end

function move!(robot::XYRobot, side::HorizonSide)
    move!(robot.robot, side)
    move!(robot.coord, side)
    println(robot.coord.x, " ", robot.coord.y)
end

isborder(robot::XYRobot,  side::HorizonSide) = isborder(robot.robot, side)
putmarker!(robot::XYRobot) = putmarker!(robot.robot)
ismarker(robot::XYRobot) = ismarker(robot.robot)
temperature(robot::XYRobot) = temperature(robot.robot)
get_coord(robot::XYRobot) = get_coord(robot.coord)

function inverse(side::HorizonSide)
    return HorizonSide(mod(Int(side)+2,4))    
end

function move!(coord::Coord, side::HorizonSide)
    if side==Nord
        coord.y += 1
    elseif side==Sud
        coord.y -= 1
    elseif side==Ost
        coord.x += 1
    elseif side==West
        coord.x -= 1
    end
end

get_coord(coord::Coord) = (coord.x, coord.y)

function go_to_corner_Sud_West!(r::XYRobot)
    while !isborder(r, Sud) || !isborder(r, West)
        while !isborder(r, Sud)
            move!(r, Sud)
        end
        while !isborder(r, West)
            move!(r, West)
        end
    end
end

function move_if_coord_notzero(r::XYRobot)
    for i in [1, 2, 3, 4]
        while (r.coord.x!=0 && r.coord.y!=0)
            move!(r, HS[i])
        end
        if r.coord.x!=0 || r.coord.y!=0
            putmarker!(r)
        end
        while !isborder(r, HS[i])
            move!(r, HS[i])
        end
    end
end

function go_to_corner!(r::XYRobot, mvs::AbstractArray)
    while isborder(r, Sud) == false || isborder(r, West) == false
        moveIfPossible!(r, mvs, Sud)
        moveIfPossible!(r, mvs, West)
        println(mvs)
    end 
end

function moveIfPossible!(r::XYRobot, mvs::AbstractArray, side::HorizonSide)
    if !isborder(r, side)
        move!(r, side)
        push!(mvs, side)
    end
end

function return_back!(r::XYRobot, mvs::AbstractArray)
    println(mvs)
    while length(mvs) > 0
        last_move = pop!(mvs)
        move!(r, inverse(last_move))
    end  
end


function main(r::Robot)
    r=XYRobot(r, (0, 0)) 
    go_to_corner!(r, mvs)
    move_if_coord_notzero(r)
    return_back!(r, mvs)
end

(1, 2, 3, 4)