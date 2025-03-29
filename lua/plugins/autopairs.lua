return {
  'windwp/nvim-autopairs',
  event = "InsertEnter",
  config = function()
    local npairs = require('nvim-autopairs')
    npairs.setup {
      check_ts = true,
      accept = { auto_brackets = { enabled = true } },
    }
    local Rule = require('nvim-autopairs.rule')
    local ts_conds = require('nvim-autopairs.ts-conds')
    npairs.add_rules({
      Rule("$", "$", { "tex", "typst" })
          :with_pair(ts_conds.is_not_ts_node("math"))
          :with_move(ts_conds.is_ts_node("math"))
    })
  end,
}
