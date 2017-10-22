local function createSpriteBatch(texture, maxSpritesPerBatch, usage)
    local newSpriteBatch = {}
    newSpriteBatch.texture = texture
    newSpriteBatch.maxSpritesPerBatch = maxSpritesPerBatch
    newSpriteBatch.usage = usage

    newSpriteBatch._batches = {}
    newSpriteBatch._count = 1

    function newSpriteBatch:clear()
        self._count = 1
        for _, batch in pairs(self._batches) do
            batch:clear()
        end
    end

    function newSpriteBatch:add(...)
        local args = {...}
        
        if #self._batches * self.maxSpritesPerBatch <= self._count then
            local newBatch = love.graphics.newSpriteBatch(self.texture, self.maxSpritesPerBatch, self.usage)
            table.insert(self._batches, newBatch)
        end
        
        self._batches[math.floor(self._count / self.maxSpritesPerBatch) + 1]:add(unpack(args))
        self._count = self._count + 1
    end

    function newSpriteBatch:draw(...)
        local args = {...}

        for _, batch in pairs(self._batches) do
            batch:flush()
            love.graphics.draw(batch, unpack(args))
        end
    end

    return newSpriteBatch
end

return createSpriteBatch
