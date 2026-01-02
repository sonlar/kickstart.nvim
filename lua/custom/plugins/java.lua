return {
  {
    'nvim-java/nvim-java',
    config = function()
      require('java').setup()
      vim.lsp.enable 'jdtls'

      local wk = require 'which-key'

      wk.add {
        { '<leader>j', group = '[J]ava', icon = { icon = '', color = 'orange' } },

        -- Build
        { '<leader>jb', group = 'Build' },
        { '<leader>jbb', "<cmd>lua require('java').build.build_workspace()<CR>", desc = 'Build Workspace' },
        { '<leader>jbc', "<cmd>lua require('java').build.clean_workspace()<CR>", desc = 'Clean Workspace' },

        -- Runner
        { '<leader>jr', group = 'Runner', icon = { icon = '󰜎', color = '' } },
        { '<leader>jrr', "<cmd>lua require('java').runner.built_in.run_app({})<CR>", desc = 'Run Application' },
        { '<leader>jra', "<cmd>lua require('java').runner.built_in.run_app({'arguments','to','pass','to','main'})<CR>", desc = 'Run with Args' },
        { '<leader>jrs', "<cmd>lua require('java').runner.built_in.stop_app()<CR>", desc = 'Stop Application' },
        { '<leader>jrl', "<cmd>lua require('java').runner.built_in.toggle_logs()<CR>", desc = 'Toggle Logs' },

        -- Debug
        { '<leader>jd', group = 'Debug' },
        { '<leader>jdc', "<cmd>lua require('java').dap.config_dap()<CR>", desc = 'Configure DAP' },

        -- Test
        { '<leader>jt', group = 'Test' },
        { '<leader>jtc', "<cmd>lua require('java').test.run_current_class()<CR>", desc = 'Run Test Class' },
        { '<leader>jtd', "<cmd>lua require('java').test.debug_current_class()<CR>", desc = 'Debug Test Class' },
        { '<leader>jtm', "<cmd>lua require('java').test.run_current_method()<CR>", desc = 'Run Method' },
        { '<leader>jtD', "<cmd>lua require('java').test.debug_current_method()<CR>", desc = 'Debug Method' },
        { '<leader>jtv', "<cmd>lua require('java').test.view_last_report()<CR>", desc = 'View Last Report' },

        -- Profiles
        { '<leader>jp', group = 'Profiles' },
        { '<leader>jpu', "<cmd>lua require('java').profile.ui()<CR>", desc = 'Profiles UI' },

        -- Refactor
        { '<leader>jx', group = 'Refactor' },
        { '<leader>jxv', "<cmd>lua require('java').refactor.extract_variable()<CR>", desc = 'Extract Variable' },
        { '<leader>jxV', "<cmd>lua require('java').refactor.extract_variable_all_occurrence()<CR>", desc = 'Extract Variable All' },
        { '<leader>jxc', "<cmd>lua require('java').refactor.extract_constant()<CR>", desc = 'Extract Constant' },
        { '<leader>jxm', "<cmd>lua require('java').refactor.extract_method()<CR>", desc = 'Extract Method' },
        { '<leader>jxf', "<cmd>lua require('java').refactor.extract_field()<CR>", desc = 'Extract Field' },

        -- Settings
        { '<leader>js', group = 'Settings', icon = { icon = '', color = 'grey' } },
        { '<leader>jsr', "<cmd>lua require('java').settings.change_runtime()<CR>", desc = 'Change Runtime' },
      }
    end,
  },
}
