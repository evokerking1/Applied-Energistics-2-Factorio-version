local LDA = require("__LDA-LIB__/init")
local PATH = LDA.setBasePath("Applied-Energistics-2")

data:extend(
    -- quando fizer 1 charger desbloquear fluix e o charged-certus-quartz-crystal
    LDA.createTechnologyCraftEntityTrigger(
        "a-quick-aside-on-fluix",
        -- unlocks
        {
            "fluix-crystal",
            "Fluix-dust",
            "charged-certus-quartz-crystal"
        },
        -- prerequisites
        {"the-charger"},
        -- item
        "charger",1
    )
)