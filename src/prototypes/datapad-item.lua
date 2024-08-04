data:extend({
    {
        type = "item",
        name = "datapad-empty",
        icon_size = 64,
        icon = "__datapad__/graphics/datapadicon_empty_64.png",
        subgroup = "tool",
        stack_size= 1,
        flags = {"not-stackable"},
        localised_description = {"item-description.datapad-empty"}
    },
    {
        type = "item-with-tags",
        name = "datapad-with-data",
        icon_size = 64,
        icon = "__datapad__/graphics/datapadicon_64.png",
        subgroup = "tool",
        stack_size= 1,
        flags = {"not-stackable"}
    },
    {
        type = "recipe",
        name = "datapad-empty",
        energy_required = 2,
        enabled = false,
        ingredients = {{"iron-plate", 2}, {"electronic-circuit", 10}, {"copper-cable", 2}, {"battery", 1}},
        result = "datapad-empty"
    },
    {
        type = "technology",
        name = "datapad",
        icon_size = 256,
        icon = "__datapad__/graphics/datapadicon_256.png",
        effects =
        {
            {
                type = "unlock-recipe",
                recipe = "datapad-empty"
            }
        },
        prerequisites = {"optics"},
        unit =
        {
            count = 10,
            ingredients = {{"automation-science-pack", 1}},
            time = 5
        }
    }
})