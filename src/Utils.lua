local utils = {}

utils.copy = function(tbl)
    local newTbl = {}

    for key, value in pairs(tbl) do
        if type(value) == 'table' then
            newTbl[key] = utils.copy(value)
        
        else
            newTbl[key] = value
        end
    end

    return newTbl
end

utils.compare = function(fromTbl, toTbl)
    for key, val in pairs(fromTbl) do
        if not (toTbl[key] and val == toTbl[key]) then
            return false
        end
    end
    return true
end

utils.find = function(findTbl, inTbl)
    for index, currTbl in ipairs(inTbl) do
        if utils.compare(findTbl, currTbl) then
            return index
        end
    end
end

return utils
