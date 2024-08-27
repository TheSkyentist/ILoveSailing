-- Load at start of game
function love.load()
    
    -- Load libraries
    Object = require "lib.classic" -- OOP library
    require "src.world"
    require "src.boat"
    require "src.field"
    require "src.force"

    -- Create constant quantities
    rho_air = ConstantField(1/700) -- kg/m^3
    rho_sea = ConstantField(1.0) -- kg/m^3
    vel_air = ConstantField({0.0, 200.0}) -- m/s
    vel_sea = ConstantField({0.0, 0.0}) -- m/s

    -- Create world
    world = World(rho_air, rho_sea, vel_air, vel_sea)

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