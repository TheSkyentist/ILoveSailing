-- Create Boat Object
Boat = Object:extend()

-- Boat Constructor
function Boat:new(Asail, Akeel, Aabove, Abelow, mass)
    
    -- Boat Position
    self.pos = {500, 500}

    -- Boat Velocity
    self.vel = {0, 0}

    -- Boat forces
    self.forces = {}

    -- Physical Properties
    self.Asail = Asail -- Area of the sail (m^2)
    self.Akeel = Akeel -- Area of the keel (m^2)
    self.Aabove = Aabove -- Area of the boat above the sea (m^2)
    self.Abelow = Abelow -- Area of the boat below the sea (m^2)
    self.mass = mass -- Mass of the boat

    -- Sail and Keel Angle
    self.sail_angle = 180 + 50 - 15 -- Degrees
    self.keel_angle = 180 + 50 -- Degrees
   
end

-- Sail Lift Ratio
function Boat:sail_lift_ratio()
    return self.Asail / self.Aabove
end

-- Keel Lift Ratio
function Boat:keel_lift_ratio()
    return self.Akeel / self.Abelow
end

-- Keel Sail Ratio
function Boat:sail_keel_ratio()
    return self.Asail / self.Akeel
end

-- Update Boat
function Boat:update(dt,world)

    -- Update Boat Velocity
    local force = self:force(dt,world)
    local accell = {force[1] / self.mass, force[2] / self.mass}
    self.vel[1] = self.vel[1] + accell[1] * dt
    self.vel[2] = self.vel[2] + accell[2] * dt

    -- Update Boat Position
    self.pos[1] = self.pos[1] + self.vel[1] * dt 
    self.pos[2] = self.pos[2] + self.vel[2] * dt

    -- Wrap around screen
    local width, height = love.graphics.getDimensions()
    self.pos[1] = self.pos[1] % width
    self.pos[2] = self.pos[2] % height

    -- Update Boat Angle
    local delta_angle = 100 * dt
    if love.keyboard.isDown("left") then
        self.keel_angle = self.keel_angle - delta_angle
        self.sail_angle = self.sail_angle - delta_angle
    end
    if love.keyboard.isDown("right") then
        self.keel_angle = self.keel_angle + delta_angle
        self.sail_angle = self.sail_angle + delta_angle
    end
    if love.keyboard.isDown("up") then
        self.sail_angle = self.sail_angle - delta_angle
    end
    if love.keyboard.isDown("down") then
        self.sail_angle = self.sail_angle + delta_angle
    end
    

end

-- Calculate force (Isotropic Boat)
function Boat:force(dt,world)

    -- Get World Properties
    local rho_air = world.rho_air:value(self.pos)
    local rho_sea = world.rho_sea:value(self.pos)
    local vel_air = world.vel_air:value(self.pos)
    local vel_sea = world.vel_sea:value(self.pos)

    -- Get Boat vectors
    local perp_sail = {math.cos(math.rad(self.sail_angle)), math.sin(math.rad(self.sail_angle))}
    local perp_keel = {math.cos(math.rad(self.keel_angle)), math.sin(math.rad(self.keel_angle))}
    local boat_to_air = {vel_air[1] - self.vel[1], vel_air[2] - self.vel[2]}
    local boat_to_sea = {vel_sea[1] - self.vel[1], vel_sea[2] - self.vel[2]}

    -- Calculate Forces
    local lift_air = flat_force(rho_air, self.Asail, perp_sail, boat_to_air)
    local drag_air = isotropic_force(rho_air, self.Aabove, boat_to_air)
    local lift_water = flat_force(rho_sea, self.Akeel, perp_keel, boat_to_sea)
    local drag_water = isotropic_force(rho_sea, self.Abelow, boat_to_sea)
    self.forces = {lift_air, drag_air, lift_water, drag_water}

    -- Net force
    local net_force = {}
    for i = 1, 2 do
        net_force[i] = 0
        for _, force in ipairs(self.forces) do
            net_force[i] = net_force[i] + force[i]
        end
    end
    return net_force

end

-- Draw Boat
function Boat:draw()

    -- Color
    love.graphics.setColor(255, 255, 255)
    
    -- Boat Parameters
    local x, y = self.pos[1], self.pos[2]
    local w, bh, fh = 15, 20, 40 -- Boat dimensions
    local angle = math.rad(self.keel_angle)
    local cosa, sina = math.cos(angle), math.sin(angle)

    -- Draw Boat
    love.graphics.polygon("fill", 
        x + w  * cosa, y + w  * sina,
        x - fh * sina, y + fh * cosa,
        x - w  * cosa, y - w  * sina,
        x + bh * sina, y - bh * cosa
    )

    -- Sail Color
    love.graphics.setColor(0, 0, 0)

    -- Sail Parameters
    local sail_length = 30
    local sail_angle = math.rad(-self.sail_angle)

    -- Draw Sail
    local mastx, masty = x - (fh / 2) * sina,  y + (fh / 2) * cosa
    love.graphics.line(
        mastx, 
        masty, 
        mastx - sail_length * math.sin(sail_angle), 
        masty - sail_length * math.cos(sail_angle))

    -- Draw Velocity
    local x, y = x - fh * sina, y + fh * cosa,
    love.graphics.setColor(0, 255, 0)
    love.graphics.line(x, y, x + self.vel[1], y + self.vel[2])


    -- Draw Accelerations (Forces)
    love.graphics.setColor(0, 0, 0)
    local x, y = 9 * love.graphics.getWidth() / 10, 9 * love.graphics.getHeight() / 10
    love.graphics.circle("fill", x, y, 5)

    -- Keep track of forces
    local accel_net = {0, 0}
    for _, force in ipairs(self.forces) do

        -- Calculate Acceleration
        local accel = {force[1] / self.mass, force[2] / self.mass}
        accel_net[1] = accel_net[1] + accel[1]
        accel_net[2] = accel_net[2] + accel[2] 

        -- Draw as Arrow
        love.graphics.line(x, y, x + accel[1], y + accel[2])
    end

    -- Draw Net Acceleration
    love.graphics.setColor(255, 255, 255)
    love.graphics.line(x, y, x + accel_net[1], y + accel_net[2])
    

end