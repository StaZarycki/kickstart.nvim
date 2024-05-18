-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  -- Toggle terminal using <c-\> keymap
  { 'akinsho/toggleterm.nvim', version = '*', opts = {
    open_mapping = [[<c-\>]],
    direction = 'float',
  } },

  -- Nvim tree
  {
    'nvim-tree/nvim-tree.lua',
    version = '*',
    lazy = false,
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      -- Disable netrw
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      -- Enable 24-bit colors
      vim.opt.termguicolors = true

      -- Custom mappings
      local function my_on_attach(bufnr)
        local api = require 'nvim-tree.api'

        local function opts(desc)
          return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        -- Default mappings
        api.config.mappings.default_on_attach(bufnr)

        -- Delete
        vim.keymap.del('n', '<C-e>', { buffer = bufnr })

        -- Set
        vim.keymap.set('n', '<C-e>', api.tree.toggle, { desc = 'Toggle nvim tree' })
        vim.keymap.set('n', '<C-t>', api.tree.change_root_to_parent, opts 'Go to parent directory')
        vim.keymap.set('n', '?', api.tree.toggle_help, opts 'Help')
      end

      require('nvim-tree').setup {
        on_attach = my_on_attach,
        filters = {
          dotfiles = false,
        },
      }

      require('nvim-tree.api').tree.open()
    end,
  },
}
