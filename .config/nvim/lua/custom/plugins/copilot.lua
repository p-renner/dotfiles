-- Use nvm's node (signed by the Node.js Foundation) instead of Homebrew's
-- ad-hoc signed one, so the macOS keychain "Always Allow" for the Copilot
-- token sticks across node upgrades.
local function nvm_node()
    local nodes = vim.fn.glob(vim.fn.expand('~/.nvm/versions/node/v*/bin/node'), false, true)
    table.sort(nodes, function(a, b)
        return vim.version.lt(a:match('v([%d.]+)/bin'), b:match('v([%d.]+)/bin'))
    end)
    return nodes[#nodes] or 'node'
end

return {
    {
        'zbirenbaum/copilot.lua',
        opts = {
            copilot_node_command = nvm_node(),
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
