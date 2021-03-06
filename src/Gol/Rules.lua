local utils = require 'src.Utils.Utils'

local function findDeadNeighbours(cycle, index)
    local deadNeighbours = {}
    for x=-1, 1 do
        for y=-1, 1 do
            if x ~= 0 or y ~= 0 then
                local nextCell = {
                    cycle[index][1] + x,
                    cycle[index][2] + y
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
    for _, cell in pairs(neighbours) do
        local added = false

        for _, pos in pairs(total) do
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

local function spawnNewCells(nextCycle, totalDeadNeighbours)
    for _, pos in pairs(totalDeadNeighbours) do
        if pos[3] == 3 then
            table.insert(nextCycle, {pos[1], pos[2]})
        end
    end
    
    return nextCycle
end

local function applyRules(prevCycle)
    local totalDeadNeighbours = {}
    local nextCycle = utils.copy(prevCycle)
    
    for i=#prevCycle, 1, -1 do
        local deadNeighbours = findDeadNeighbours(prevCycle, i)
        stackNeighbours(totalDeadNeighbours, deadNeighbours)
        
        if #deadNeighbours > 6 or #deadNeighbours < 5 then
            table.remove(nextCycle, i)
        end
    end
    
    return spawnNewCells(nextCycle, totalDeadNeighbours)
end

return applyRules
