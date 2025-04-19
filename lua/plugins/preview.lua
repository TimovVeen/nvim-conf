return {
  'chomosuke/typst-preview.nvim',
  ft = 'typst',
  version = '1.*',
  opts = {
    open_cmd = 'firefox-bin %s -P blank',

    dependencies_bin = {
      ['tinymist'] = '/usr/bin/tinymist',
      ['websocat'] = '/usr/bin/websocat'
    }
  },
}
