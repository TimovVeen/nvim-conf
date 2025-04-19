local function call(method)
  return function()
    require('fzf-lua')[method]()
  end
end

return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { 'ff', call('files'),        desc = 'Search files' },
    { 'fl', call('lines'),        desc = 'Search open lines' },
    { 'fp', call('grep_project'), desc = 'Search project lines' },
    { 'fg', call('grep'),         desc = 'Search pattern' },
    { 'fw', call('grep_cword'),   desc = 'Search word' },
    { 'fr', call('resume'),       desc = 'Resume last search' },
  },
  opts = {}
}
