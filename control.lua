-- control.lua
-- Descontinuada.(use `storage`)

-- require("control/functions")
--require("control/start_itens")
-- require("control/gui/gui-loader")

local MeteoriteSpawn = require("scripts.meteorite-spawn")

local TICKS_PER_SECOND = 60
local SECONDS_PER_MINUTE = 60
local TICKS_PER_MINUTE = TICKS_PER_SECOND * SECONDS_PER_MINUTE

--- Retorna o valor da configuração de intervalo de spawn dos meteoritos.
--- @return number
local function getMeteoriteIntervalTicks()
    local interval_minutes = settings.global["AE2_meteorite_interval_minutes"].value or 20
    return interval_minutes * TICKS_PER_MINUTE
end

--- Retorna se o sistema de meteoritos está habilitado.
--- @return boolean
local function isMeteoriteSystemEnabled()
    return settings.global["AE2_enable_meteorites"].value == true
end

--- Inicializa dados persistentes do mod.
--- @return nil
local function initialize()
    storage.ae2 = storage.ae2 or {}
    storage.ae2.last_meteorite_tick = storage.ae2.last_meteorite_tick or 0
end

--- Verifica se já passou tempo suficiente para spawnar um novo meteorito.
--- @param current_tick number
--- @return boolean
local function shouldSpawnMeteorite(current_tick)
    local interval_ticks = getMeteoriteIntervalTicks()
    local last_tick = storage.ae2.last_meteorite_tick or 0

    return (current_tick - last_tick) >= interval_ticks
end

script.on_init(function()
    initialize()
end)

script.on_configuration_changed(function()
    initialize()
end)

script.on_event(defines.events.on_runtime_mod_setting_changed, function(event)
    if event.setting == "AE2_enable_meteorites" or event.setting == "AE2_meteorite_interval_minutes" then
        initialize()
    end
end)

script.on_event(defines.events.on_tick, function(event)
    initialize()

    if not isMeteoriteSystemEnabled() then
        return
    end

    if not shouldSpawnMeteorite(event.tick) then
        return
    end

    local success = MeteoriteSpawn.trySpawnNearRandomPlayer()

    if success then
        storage.ae2.last_meteorite_tick = event.tick
    end
end)