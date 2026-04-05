local LDA = require("__LDA-LIB__/init")
local PATH = LDA.setBasePath("Applied-Energistics-2")
local utilsAnimations = LDA.utilsAnimations
local LDAutils = LDA.utils
local sounds = require("__base__/prototypes/entity/sounds")
local fireutil = require("__base__/prototypes/fire-util")
local crash_site_sprite_priority = "very-low"
local baseResourceMultiplier = 0.20
local wreck_flags = {
    "placeable-player",
    "player-creation",
    "not-rotatable",
    "placeable-off-grid",
    "not-blueprintable",
    "not-deconstructable"
}
-- createAnimationLayer(filename, width, height, hr_scale,shift,draw_as_shadow, custom_props)

data:extend(
    {
        {
            type = "container",
            name = "crash-site-meteorite",
            icon = PATH .. "graphics/entity/the-mysterious-cube.png",
            flags = wreck_flags,
            hidden = true,
            max_health = 1350,
            minable = {mining_time = 10},
            corpse = "big-remnants",
            open_sound = sounds.metallic_chest_open,
            close_sound = sounds.metallic_chest_close,
            surface_conditions = {
                {
                    property = "gravity",
                    min = 0.1
                }
            },
            resistances = {
                LDAutils.createResistance("fire", 90),
                LDAutils.createResistance("impact", 60)
            },
            -- x_max = 1.2, y_max = 1.2 (automático)
            collision_box = LDAutils.createBoundingBox(3.0),
            -- x_max = 1.5, y_max = 1.5 (automático)
            selection_box = LDAutils.createBoundingBox(3.2),
            fast_replaceable_group = "container",
            inventory_size = 4,
            integration_patch = {
                filename = "__base__/graphics/entity/crash-site-chests/crash-site-chest-1-ground.png",
                priority = crash_site_sprite_priority,
                width = 220,
                height = 148,
                shift = util.by_pixel(-6, 12),
                scale = 1
            },
            picture = {
                layers = {
                    -- createAnimationLayer(filename, width, height, hr_scale,shift,draw_as_shadow, custom_props)
                    utilsAnimations.createAnimationLayer(
                        PATH .. "graphics/entity/crash-site-meteorite", -- filename
                        780,
                        559,
                        nil,
                        util.by_pixel(2, 8),
                        false,
                        {
                            -- custom_props
                            priority = "extra-high"
                        }
                    ),
                    utilsAnimations.createAnimationLayer(
                        -- "__base__/graphics/entity/crash-site-chests/crash-site-chest-1-shadow", -- filename
                        PATH .. "graphics/entity/crash-site-meteorite", -- filename
                        210, -- width (Base)
                        128, -- height (Base)
                        nil,
                        util.by_pixel(-2, 3),
                        true,
                        {
                            -- custom_props
                            priority = "extra-high"
                        }
                    )
                }
            },
            circuit_connector = circuit_connector_definitions["chest"],
            circuit_wire_max_distance = default_circuit_wire_max_distance
        }
    }
)

-- Defina as configurações de geração para suas pedras personalizadas
-- data:extend(
--     {
--         {
--             type = "container",
--             name = "meteorite",
--             icon = PATH .. "graphics/entity/meteorite.png",
--             icon_size = 128,
--             icon_mipmaps = 4,
--             flags = {"placeable-neutral"},
--             order = "a-b-a",
--             subgroup = "raw-resource",
--             category = "basic-solid",
--             highlight = true,
--             infinite = false,
--             minimum = 10 * baseResourceMultiplier,
--             normal = 10 * baseResourceMultiplier,
--             tree_removal_max_distance = 32 * 32,
--             minable = {
--                 hardness = 8,
--                 mining_particle = "stone-particle",
--                 mining_time = 3,
--                 results = {
--                     {
--                         type = "item",
--                         name = "silicon-press",
--                         amount_min = 1,
--                         amount_max = 1
--                     },
--                     {
--                         type = "item",
--                         name = "engineering-processor-press",
--                         amount_min = 1,
--                         amount_max = 1
--                     },
--                     {
--                         type = "item",
--                         name = "logic-processor-press",
--                         amount_min = 1,
--                         amount_max = 1
--                     },
--                     {
--                         type = "item",
--                         name = "calculation-processor-press",
--                         amount_min = 1,
--                         amount_max = 1
--                     }
--                 }
--             },
--             collision_box = {
--                 {-1.2, -1.2},
--                 {1.2, 1.2}
--             },
--             selection_box = {
--                 {-1.5, -1.5},
--                 {1.5, 1.5}
--             },
--             autoplace = {
--                 name = "mysterious-cube",
--                 order = "d[ore]-a[mysterious-cube]",
--                 --Densidade base do recurso.
--                 base_density = 10 * baseResourceMultiplier,
--                 base_spots_per_km2 = 7.5 * baseResourceMultiplier,
--                 --geração
--                 richness = true,
--                 has_starting_area_placement = false,
--                 random_spot_size_minimum = 2.5 * baseResourceMultiplier,
--                 random_spot_size_maximum = 30 * baseResourceMultiplier,
--                 regular_blob_amplitude_multiplier = 10 * baseResourceMultiplier,
--                 regular_rq_factor_multiplier = 9 * baseResourceMultiplier,
--                 candidate_spot_count = 220 * baseResourceMultiplier
--             },
--             stage_counts = {0},
--             stages = {
--                 sheet = {
--                     frame_count = 1,
--                     filename = PATH .. "graphics/entity/the_mysterious_cube.png",
--                     hr_version = {
--                         frame_count = 1,
--                         filename = PATH .. "graphics/entity/the_mysterious_cube.png",
--                         scale = 0.5,
--                         priority = "extra-high",
--                         size = 128,
--                         variation_count = 1
--                     },
--                     {
--                         filename = PATH .. "graphics/entity/the_mysterious_cube.png",
--                         height = 128,
--                         shift = {0.3125, 0.203125},
--                         priority = "extra-high",
--                         width = 128,
--                         draw_as_shadow = true
--                     },
--                     priority = "extra-high",
--                     size = 128,
--                     variation_count = 1
--                 }
--             },
--             map_grid = false,
--             map_color = {r = 255, g = 0, b = 255}
--         }
--     }
-- )
