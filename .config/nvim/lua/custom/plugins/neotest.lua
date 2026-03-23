return {
    {
        'nvim-neotest/neotest',
        dependencies = {
            'nvim-neotest/nvim-nio',
            'nvim-lua/plenary.nvim',
            'antoinemadec/FixCursorHold.nvim',
            'nvim-treesitter/nvim-treesitter',
            'nvim-neotest/neotest-jest',
        },
        config = function()
            require('neotest').setup {
                adapters = {
                    require 'neotest-jest' {
                        jestCommand = 'npm test --',
                        jestArguments = function(defaultArguments, context)
                            return defaultArguments
                        end,
                        jestConfigFile = 'jest.config.ts',
                        env = { CI = true },
                        cwd = function(path)
                            return vim.fn.getcwd()
                        end,
                        isTestFile = function(filePath)
                            -- Working directory is 'leetcode' folder
                            if string.find(filePath, 'leetcode/') then
                                return true
                            end

                            return require('neotest-jest.jest-util').defaultIsTestFile(filePath)
                        end,
                    },
                },
            }

            vim.keymap.set('n', '<leader>tt', function()
                require('neotest').run.run()
            end, { desc = 'Neotest: Run nearest test' })
        end,
    },
}
