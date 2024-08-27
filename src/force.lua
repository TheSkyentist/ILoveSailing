-- Dot product of two 2D vectors
local function dot(v1, v2)
    return v1[1] * v2[1] + v1[2] * v2[2]
end

-- Norm (magnitude) of a 2D vector
local function norm(v)
    return math.sqrt(v[1]^2 + v[2]^2)
end

-- Scalar multiplication of a 2D vector (in place)
local function scalar_mult(v, s)
    return {v[1] * s, v[2] * s}
end

-- Outer product of two 2D vectors resulting in a 2x2 matrix
local function outer(v1, v2)
    return {
        {v1[1] * v2[1], v1[1] * v2[2]},
        {v1[2] * v2[1], v1[2] * v2[2]}
    }
end

-- Ram-pressure force on a flat surface of area A.
function flat_force(rho, A, e, dv)
    local edv = dot(e, dv)
    local sign_edv = edv >= 0 and 1 or -1
    local force = scalar_mult(e, rho * A * (edv)^2 * sign_edv)
    return force, derivative
end

-- Ram-pressure force on an isotropic object of projected area A.
function isotropic_force(rho, A, dv)
    local adv = norm(dv)
    local force = scalar_mult(dv, rho * A * adv)
    return force
end
