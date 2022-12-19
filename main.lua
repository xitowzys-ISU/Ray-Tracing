require("vector")
require("obstacle")
require("ray")
require('radiant')
require('radiantUnique')
require("vision")

function love.load()
    width = love.graphics.getWidth()
    height = love.graphics.getHeight()


    obstacles = {}

    local points = { { 0, 0 }, { width, 0 }, { width, height }, { 0, height }, { 0, 0 } }
    obstacles[1] = Obstacle:create(points)

    points = { { 100, 100 }, { 100, 200 }, { 200, 200 }, { 200, 100 }, { 100, 100 } }
    obstacles[2] = Obstacle:create(points)

    points = { { 500, 100 }, { 650, 100 }, { 650, 300 }, { 500, 100 } }
    obstacles[3] = Obstacle:create(points)

    points = { { 450, 400 }, { 650, 500 }, { 480, 600 }, { 380, 420 }, { 450, 400 } }
    obstacles[4] = Obstacle:create(points)

    points = { { 80, 300 }, { 140, 300 }, { 140, 470 }, { 120, 470 }, { 80, 300 } }
    obstacles[5] = Obstacle:create(points)


    segments = {}
    for i = 1, #obstacles do
        points = obstacles[i].points

        for j = 2, #points do
            table.insert(segments, { points[j - 1], points[j], i })
        end

    end

    Vision = Vision:create(width / 2, height / 2, 30)
end

function love.update(dt)
    for i = 1, #obstacles do
        obstacles[i]:update()
    end

    local x, y = love.mouse.getPosition()
    Vision:update(x, y)

end

function love.draw()
    for i = 1, #obstacles do
        obstacles[i]:draw()
    end
    Vision:draw()
end
