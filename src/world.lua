-- Create World Object
World = Object:extend()

-- World Constructor
function World:new(rho_air, rho_sea, vel_air, vel_sea, boat)
    
    -- World Physics
    self.rho_air = rho_air
    self.rho_sea = rho_sea

    -- World Velocities
    self.vel_air = vel_air
    self.vel_sea = vel_sea

    -- Boat (Area of sail, keel, above, below, and mass)
    local lift_ratio = 200
    local sail_keel_ratio = 10
    self.boat = boat

end

-- Update World
function World:update(dt)

    -- Update Boat
    self.boat:update(dt,self)

    -- Update Physics
    local physics = {self.rho_air, self.rho_sea, self.vel_air, self.vel_sea}
    for i, p in ipairs(physics) do
        p:update(dt)
    end


end

-- Draw World
function World:draw()


    -- Get Window Size
    local width, height = love.graphics.getDimensions()

    -- Draw Sea
    love.graphics.setColor(0, 0, 255)
    love.graphics.rectangle("fill", 0, 0, width, height)


    -- Draw Boat
    self.boat:draw()

end