require("obsidian").setup({
    workspaces = {
        {
            name = "main", -- The name for this workspace
            path = "~/projects/obsidian-vault", -- The path to your vault
        },
    },
  ui = {enable = false}

    -- OPTIONAL: Add common options here
    -- For example, to set up keybindings:
    -- mappings = {
    --     -- Normal mode
    --     ["gf"] = {
    --         action = function()
    --             return require("obsidian").util.split_or_open_link()
    --         end,
    --         opts = { silent = true, noremap = true },
    --     },
    -- },

    -- To enable daily notes and set a preferred file format:
    -- daily_notes = {
    --     folder = "daily",
    --     date_format = "%Y-%m-%d", -- e.g., 2023-10-17
    --     alias_format = "%A, %B %d, %Y", -- e.g., Thursday, October 17, 2025
    -- },

    -- To set the template path
    -- templates = {
    --     subdir = "templates",
    -- },
})
