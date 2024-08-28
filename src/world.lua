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

    -- Boat
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

    -- Draw Air/Water Velocities
    local x, y = width / 10, height / 10
    love.graphics.setColor(0, 0, 0)
    love.graphics.circle("fill", x, y, 5)

    -- Draw Air Velocity
    love.graphics.setColor(255, 0, 0)
    local vel_air = self.vel_air:value({x, y})
    love.graphics.line(x, y, x + vel_air[1], y + vel_air[2])

    -- Draw Sea Velocity
    love.graphics.setColor(0, 255, 255)
    local vel_sea = self.vel_sea:value({x, y})
    love.graphics.line(x, y, x + vel_sea[1], y + vel_sea[2])

    -- Draw Boat
    self.boat:draw()

end