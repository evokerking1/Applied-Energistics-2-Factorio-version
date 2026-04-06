-- control.lua
-- Descontinuada.(use `storage`)

-- require("control/functions")
--require("control/start_itens")
-- require("control/gui/gui-loader")

local MeteoriteSpawn = require("scripts.meteorite-spawn")

local TICKS_PER_MINUTE = 60 * 60
local METEORITE_INTERVAL = 20 * TICKS_PER_MINUTE -- a cada 20 minutos

--- Inicializa dados globais.
--- @return nil
local function initialize()
    storage.ae2 = storage.ae2 or {}
    storage.ae2.last_meteorite_tick = storage.ae2.last_meteorite_tick or 0
end

script.on_init(function()
    initialize()
end)

script.on_configuration_changed(function()
    initialize()
end)

script.on_nth_tick(METEORITE_INTERVAL, function(event)
    initialize()

    local success = MeteoriteSpawn.trySpawnNearRandomPlayer()

    if success then
        storage.ae2.last_meteorite_tick = event.tick
    end
end)