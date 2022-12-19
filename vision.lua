Vision = {}
Vision.__index = Vision

function Vision:create(x, y, fov, rays, limit)
    local vision = {}
    setmetatable(vision, Vision)
    vision.location = Vector:create(x, y)
    vision.angle    = 0
    vision.fov      = fov
    vision.amount   = rays or 33
    vision.rays     = {}
    vision.start    = 0
    vision.step     = 0
    vision.limit    = limit or width + height

    vision:init()

    return vision
end

function Vision:init()
    self.fov = self.fov * 0.006 * math.pi
    for i = 1, self.amount do
        self.rays[i] = Ray:create({ self.location.x, self.location.y })
    end

    self.start = -self.fov * 0.5
    self.step  = self.fov / (self.amount - 1)
end

function Vision:update(x, y)
    local vector = Vector:create(x - self.location.x, y - self.location.y)
    local rangle = vector:heading() + self.start

    self.angle = vector:heading() + math.pi * 0.5
    for i = 1, self.amount do
        self.rays[i]:lineTo({ self.rays[i].origin[1] + math.cos(rangle), self.rays[i].origin[2] + math.sin(rangle) },
            segments)

        rangle = rangle + self.step
    end
end

function Vision:draw()
    love.graphics.push()

    love.graphics.translate(self.location.x, self.location.y)
    love.graphics.rotate(self.angle)

    local r, g, b, a = love.graphics.getColor()

    love.graphics.setColor(1, 1, 1)
    love.graphics.circle("line", 0, 0, 10)

    love.graphics.setColor(1, 0, 0)
    love.graphics.rotate(self.start)
    love.graphics.line(0, -15, 0, -height)

    love.graphics.rotate(self.fov)
    love.graphics.line(0, -15, 0, -height)
    love.graphics.setColor(r, g, b, a)

    love.graphics.pop()
end
