return {
    "epwalsh/obsidian.nvim",
    version = "*",
    lazy = true,
    ft = "markdown",

    dependencies = {
        "nvim-lua/plenary.nvim",
    },

    cmd = {
        "ObsidianOpen",
        "ObsidianNew",
        "ObsidianQuickSwitch",
        "ObsidianFollowLink",
        "ObsidianBacklinks",
        "ObsidianToday",
        "ObsidianYesterday",
        "ObsidianTemplate",
        "ObsidianSearch",
        "ObsidianLink",
        "ObsidianLinkNew",
    },

    opts = {
        workspaces = {
            {
                name = "vault",
                path = "~/vault",
            },
        },
        daily_notes = {
            folder = "Daily Notes",
            -- Optional, if you want to change the date format for the ID of daily notes.
            -- date_format = "%Y-%m-%d",
            -- Optional, if you want to change the date format of the default alias of daily notes.
            -- alias_format = "%B %-d, %Y",
        },
    },

    config = function(_, opts)
        require("obsidian").setup(opts)
        vim.keymap.set("n", "gd", function()
            if require("obsidian").util.cursor_on_markdown_link() then
                return "<cmd>ObsidianFollowLink<CR>"
            else
                return "gd"
            end
        end, { noremap = false, expr = true })
    end,
}
