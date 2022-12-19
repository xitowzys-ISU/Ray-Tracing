require("vector")
require("obstacle")
require("ray")
require('radiant')
require('radiantUnique')

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

    --ray = Ray:create({ width / 2, height /2 }, { width, height })
    radiant = RadiantUnique:create(50000)
    segments = {}
    for i = 1, #obstacles do
        points = obstacles[i].points

        for j = 2, #points do
            table.insert(segments, { points[j - 1], points[j] })
        end

    end
    --print("Total segments: " .. tostring(#segments))

end

function love.update(dt)
    --print(love.mouse.getPosition()[0])
    --local x, y = love.mouse.getPosition()
    --print("Total segments: " .. tostring(#segments))
    --ray:lineTo({x, y}, segments)
    --print(segments[1])
    radiant:update(segments)
end

function love.draw()
    for i = 1, #obstacles do
        obstacles[i]:draw()
    end
    --ray:draw()
    radiant:draw()
end
