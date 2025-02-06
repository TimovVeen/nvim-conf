return {
  'martineausimon/nvim-lilypond-suite',
  config = function()
    require('nvls').setup {
      lilypond = {
        options = {
          pdf_viewer = 'zathura',
        },
      },
      latex = {
        options = {
          pdf_viewer = 'zathura',
        },
      },
      player = {
        options = {
          fluidsynth_flags = {
            '-a pipewire',
            '/usr/share/sounds/sf2/default.sf2',
            -- "-g", "2",
          },
        },
      },
    }
  end,
}
