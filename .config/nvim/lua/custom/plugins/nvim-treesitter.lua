return {
    {
        -- Highlight, edit, and navigate code
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            { 'nvim-treesitter/nvim-treesitter-textobjects', branch = 'main' },
        },
        build = ':TSUpdate',
        branch = 'main',
        lazy = false,
        config = function()
            require('nvim-treesitter').setup()

            -- Enable treesitter highlighting and indentation per filetype
            vim.api.nvim_create_autocmd('FileType', {
                callback = function()
                    pcall(vim.treesitter.start)
                    vim.bo.indentexpr = "v:lua.require('nvim-treesitter').indentexpr()"
                end,
            })

            -- Textobjects: select
            local sel = require('nvim-treesitter-textobjects.select')
            for _, map in ipairs({
                { 'aa', '@parameter.outer' },
                { 'ia', '@parameter.inner' },
                { 'af', '@function.outer' },
                { 'if', '@function.inner' },
                { 'ac', '@class.outer' },
                { 'ic', '@class.inner' },
            }) do
                vim.keymap.set({ 'x', 'o' }, map[1], function()
                    sel.select_textobject(map[2], 'textobjects')
                end)
            end

            -- Textobjects: move
            require('nvim-treesitter-textobjects').setup { move = { set_jumps = true } }
            local mov = require('nvim-treesitter-textobjects.move')
            for _, map in ipairs({
                { ']m', 'goto_next_start',     '@function.outer' },
                { ']]', 'goto_next_start',     '@class.outer' },
                { ']M', 'goto_next_end',       '@function.outer' },
                { '][', 'goto_next_end',       '@class.outer' },
                { '[m', 'goto_previous_start', '@function.outer' },
                { '[[', 'goto_previous_start', '@class.outer' },
                { '[M', 'goto_previous_end',   '@function.outer' },
                { '[]', 'goto_previous_end',   '@class.outer' },
            }) do
                vim.keymap.set('n', map[1], function()
                    mov[map[2]](map[3], 'textobjects')
                end)
            end

            -- Textobjects: swap
            local swp = require('nvim-treesitter-textobjects.swap')
            vim.keymap.set('n', '<leader>a', function() swp.swap_next('@parameter.inner') end)
            vim.keymap.set('n', '<leader>A', function() swp.swap_previous('@parameter.inner') end)
        end,
    },
}
