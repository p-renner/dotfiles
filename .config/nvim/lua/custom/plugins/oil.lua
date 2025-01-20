return {
    {
        'stevearc/oil.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        keys = {
            { '-', '<CMD>Oil<CR>', desc = 'Open parent directory' },
        },
        config = function()
            require('oil').setup {
                keymaps = {
                    ['<C-h>'] = false, -- Open in horizontal split
                    ['<C-l>'] = false, -- Refresh
                },
                view_options = {
                    show_hidden = true,
                },
            }
        end,
    },
}
