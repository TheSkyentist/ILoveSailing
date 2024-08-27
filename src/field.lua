-- Physical Fields
-- Can be scalar or vector fields
-- Can be spatially constant or spatially varying
-- Can be temporally constant or time-dependent
-- Used for modelling the sea and air properties (both density and velocity)

-- Create Field Object
Field = Object:extend()

-- Field Constructor
function Field:new()
end

-- Get Field Value at Position at current time
function Field:value(pos)
    return nil
end

-- Update Field
function Field:update(dt)
end

-- Create Constant Field Object
ConstantField = Field:extend()

-- Constant Field Constructor
function ConstantField:new(const)
    self.const = const
end

-- Get Constant Field Value at Position at current time
function ConstantField:value(pos)
    return self.const
end