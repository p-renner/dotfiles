return {
    {
        "zbirenbaum/copilot.lua",
        opts = {
            suggestion = {
                enabled = true,
                auto_trigger = true,
                keymap = { accept = "<C-j>" }
            },
            filetypes = {
                markdown = true,
                yaml = true,
            },
        }
    }
}
