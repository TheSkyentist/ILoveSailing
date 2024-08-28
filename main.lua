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
    local Asail = 8 * (pxpm ^ 2) -- m^2
    local sail_keel_ratio = 700
    local lift_ratio = 200
    local boat = Boat(
        Asail, -- Area Sail
        Asail / sail_keel_ratio, -- Area Keel
        8 / lift_ratio, -- Area Above
        8 / lift_ratio, -- Area Below
        150 -- Mass [kg]
    )

    -- Create constant quantities
    local rho_air = ConstantField(1 / 700) -- kg/m^3 (Not affected by scale)
    local rho_sea = ConstantField(1.0) -- kg/m^3 (Not affected by scale)
    local vel_air = ConstantField({0.0 * pxpm, 30.0 * pxpm}) -- m/s
    local vel_sea = ConstantField({1.5 * pxpm,  0.0 * pxpm}) -- m/s

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
end 