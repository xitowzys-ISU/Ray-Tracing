Obstacle = {}
Obstacle.__index = Obstacle

function Obstacle:create(points)
    local obstacle = {}
    setmetatable(obstacle, Obstacle)
    obstacle.points = points

    return obstacle
end

function Obstacle:draw()
    r, g, b, a = love.graphics.getColor()
    love.graphics.setColor(1, 1, 1)

    for i = 2, #self.points do
        p1 = self.points[i - 1]
        p2 = self.points[i]
        love.graphics.line(p1[1], p1[2], p2[1], p2[2])
    end

    love.graphics.setColor(r, g, b, a)
end
