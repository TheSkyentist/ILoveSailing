-- Load at start of game
function love.load()
    
    -- Load libraries
    Object = require "lib.classic" -- OOP library
    require "src.world"
    require "src.boat"
    require "src.field"
    require "src.force"

    -- Pixel scale
    pxpm = 10 -- pixels/meter

    -- Create boat
    local Asail = 8 * (pxpm ^ 2)
    local sail_keel_ratio = 10
    local lift_ratio = 200
    local boat = Boat(
        Asail, -- Area Sail
        Asail / sail_keel_ratio, -- Area Keel
        8 / lift_ratio, -- Area Above
        8 / lift_ratio, -- Area Below
        100 -- Mass 
    )

    -- Create constant quantities
    local rho_air = ConstantField(1 / 700) -- kg/m^3
    local rho_sea = ConstantField(1.0) -- kg/m^3
    local vel_air = ConstantField({0.0, 30.0 * pxpm}) -- m/s
    local vel_sea = ConstantField({0.0, 0.0}) -- m/s

    -- Create world
    world = World(rho_air, rho_sea, vel_air, vel_sea, boat)

end

-- Main game loop
function love.draw()
    world:draw()
end

-- Update game state
function love.update(dt)
    world:update(dt)
    -- Force exit

end 