return {
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'make',

                cond = function()
                    return vim.fn.executable 'make' == 1
                end,
            },
            { 'nvim-telescope/telescope-ui-select.nvim' },
            { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
        },
        keys = function(_, keys)
            local builtin = require 'telescope.builtin'
            return {
                { '<leader>ss', builtin.builtin, desc = '[S]earch [S]elect Telescope' },
                { '<leader>gf', builtin.git_files, desc = 'Search [G]it [F]iles' },
                { '<leader>sf', builtin.find_files, desc = '[S]earch [F]iles' },
                { '<leader>sh', builtin.help_tags, desc = '[S]earch [H]elp' },
                { '<leader>sw', builtin.grep_string, desc = '[S]earch current [W]ord' },
                { '<leader>sg', builtin.live_grep, desc = '[S]earch by [G]rep' },
                { '<leader>sd', builtin.diagnostics, desc = '[S]earch [D]iagnostics' },
                { '<leader>sr', builtin.resume, desc = '[S]earch [R]esume' },
                { '<leader>sk', builtin.keymaps, desc = '[S]earch [K]eymaps' },
                { '<leader>?', builtin.oldfiles, desc = '[?] Find recently opened files' },
                { '<leader><space>', builtin.buffers, desc = '[ ] Find existing buffers' },
                {
                    '<leader>/',
                    function()
                        -- You can pass additional configuration to telescope to change theme, layout, etc.
                        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
                            winblend = 10,
                            previewer = false,
                        })
                    end,
                    desc = '[/] Fuzzily search in current buffer',
                },
                {
                    '<leader>s/',
                    function()
                        builtin.live_grep {
                            grep_open_files = true,
                            prompt_title = 'Live Grep in Open Files',
                        }
                    end,
                    desc = '[S]earch [/] in Open Files',
                },

                -- Shortcut for searching your Neovim configuration files
                {
                    '<leader>sn',
                    function()
                        builtin.find_files { cwd = vim.fn.stdpath 'config' }
                    end,
                    desc = '[S]earch [N]eovim files',
                },

                unpack(keys),
            }
        end,
        config = function()
            local telescope = require 'telescope'
            pcall(telescope.load_extension, 'fzf')
            pcall(telescope.load_extension, 'ui-select')
        end,
    },
}
