local utils = require 'src.Utils'

local function findDeadNeighbours(cycle, index)
    local deadNeighbours = {}
    for x=-1, 1 do
        for y=-1, 1 do
            if x ~= 0 or y ~= 0 then
                local nextCell = {
                    cycle[index + x],
                    cycle[index + y]
                }

                if not utils.find(nextCell, cycle) then
                    table.insert(deadNeighbours, nextCell)
                end
            end
        end
    end

    return deadNeighbours
end

local function stackNeighbours(total, neighbours)
    for cell in neighbours do
        local added = false

        for pos in total do
            if utils.compare(cell, pos) then
                pos[3] = pos[3] + 1
                added = true
                break
            end
        end

        if not added then
            table.insert(total, {cell[1], cell[2], 1})
        end
    end
end

local function applyRules(prevCycle)
    local totalDeadNeighbours = {}
    local nextCycle = utils.copy(prevCycle)

    for i=#prevCycle, 1, -1 do
        deadNeighbours = findDeadNeighbours(prevCycle, i)
        stackNeighbours(totalDeadNeighbours, deadNeighbours)

        if #deadNeighbours > 6 or #deadNeighbours < 5 then
            table.remove(nextCycle, i)
        end
    end
end

return applyRules
