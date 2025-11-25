return {
    {
        'zbirenbaum/copilot.lua',
        opts = {
            panel = {
                enabled = true,
                auto_refresh = true,
            },
            suggestion = {
                enabled = true,
                auto_trigger = true,
                keymap = {
                    accept = '<C-j>',
                },
            },
            filetypes = {
                markdown = true,
                yaml = true,
            },
        },
    },
}
