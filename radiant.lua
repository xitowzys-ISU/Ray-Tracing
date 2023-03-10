Radiant = {}
Radiant.__index = Radiant

function Radiant:create(n)
    local radiant = {}
    setmetatable(radiant, Radiant)
    radiant.n = n or 4
    radiant.position = { 400, 300 }
    radiant.rays = {}
    radiant.dxdy = {}

    for rad = 0, 2 * math.pi, (2 * math.pi) / radiant.n do
        table.insert(radiant.rays, Ray:create(radiant.position, { 0, 0 }))
        table.insert(radiant.dxdy, { math.cos(rad), math.sin(rad) })
    end

    return radiant
end

function Radiant:update(segments)
    x, y = love.mouse.getPosition()
    self.position[1] = x
    self.position[2] = y
    for i = 1, #self.rays do
        ray = self.rays[i]
        dxdy = self.dxdy[i]
        ray:lineTo({ x + dxdy[1], y + dxdy[2] }, segments)
    end
end

function Radiant:draw()
    r, g, b, a = love.graphics.getColor()
    love.graphics.setColor(1, 0, 0)
    love.graphics.circle("fill", self.position[1], self.position[2], 5)
    for i = 1, #self.rays do
        self.rays[i]:draw()
    end

    love.graphics.setColor(r, g, b, a)

end
