local Banners = {}

Banners.big = {
  [[     \\XXXXXX//]],
  [[      XXXXXXXX]],
  [[     //XXXXXX\\                      OOOOOOOOOOOOOOOOOOOO]],
  [[    ////XXXX\\\\                     OOOOOOOOOOOOOOOOOOOO]],
  [[   //////XX\\\\\\     |||||||||||||||OOOOOOOOOOOOOOOVVVVVVVVVVVVV]],
  [[  ////////\\\\\\\\    |!!!|||||||||||OOOOOOOOOOOOOOOOVVVVVVVVVVV]],
  [[ ////////  \\\\\\\\ .d88888b|||||||||OOOOOOOOOOOOOOOOOVVVVVVVVV]],
  [[////////    \\\\\\\d888888888b||||||||||||            'VVVVVVV']],
  [[///////      \\\\\\d88888888888||||||||||||             'VVVVV']],
  [[//////        \\\\\Y888888888Y||||||||||||              'VVV']],
  [[/////          \\\\\\Y88888Y|||||||||||||| .             'V']],
  [[////            \\\\\\|iii|||||||||||||||!:::.            ']],
  [[///              \\\\\\||||||||||||||||!:::::::.]],
  [[//                \\\\\\\\           .:::::::::::.]],
  [[/                  \\\\\\\\        .:::::::::::::::.]],
  [[                    \\\\\\\\     .:::::::::::::::::::.]],
  [[                     \\\\\\\\]],
}

Banners.small = {
  [[                                                            ]],
  [[ |     .-.                                                  ]],
  [[ |    /   \         .-.                                     ]],
  [[ |   /     \       /   \       .-.     .-.     _   _        ]],
  [[ +--/-------\-----/-----\-----/---\---/---\---/-\-/-\/\/--- ]],
  [[ | /         \   /       \   /     '-'     '-'              ]],
  [[ |/           '-'         '-'                               ]],
  [[                                                            ]],
}

return {
  enabled = true,
  preset = {
    ---@type snacks.dashboard.Item[]|fun(items:snacks.dashboard.Item[]):snacks.dashboard.Item[]?
    keys = {
      { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
      { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
      {
        icon = " ",
        key = "g",
        desc = "Find Text",
        action = ":lua Snacks.dashboard.pick('live_grep')",
      },
      {
        icon = " ",
        key = "r",
        desc = "Recent Files",
        action = ":lua Snacks.dashboard.pick('oldfiles')",
      },
      {
        icon = " ",
        key = "c",
        desc = "Config",
        action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
      },
      { icon = " ", key = "s", desc = "Restore Session", section = "session" },
      { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy },
      { icon = " ", key = "q", desc = "Quit", action = ":qa" },
    },
    header = Banners.big,
  },
  formats = {
    terminal = { align = "center" },
    version = { "%s", align = "center" },
  },

  width = 60,
  pane_gap = 20,

  sections = {
    {
      section = "header",
      height = 25,
      width = 10,
      enabled = function()
        return vim.fn.environ()["SSH_CLIENT"] ~= nil
      end,
    },
    {
      section = "terminal",
      -- cmd = "img2art ~/Descargas/tn8.jpg --threshold 20 --scale .10 --quant 32 --with-color",
      cmd = [[ ascii-image-converter ~/Descargas/tn8.jpg -C -c]],
      -- cmd = [[ curl parrot.live ]],
      ttl = 0,
      height = 23,
      width = 50,
      indent = 18,
      padding = 1,
    },
    { section = "keys", gap = 0, padding = 1 },
    { section = "startup" },

    function()
      local in_git = Snacks.git.get_root() ~= nil
      local cmds = {
        {
          title = "Git Graph",
          icon = " ",
          cmd = [[echo -e "$(git-graph --style round --color always --wrap 50 0 8 -f 'oneline')"]],
          indent = 1,
          height = 33,
        },
      }
      return vim.tbl_map(function(cmd)
        return vim.tbl_extend("force", {
          pane = 2,
          section = "terminal",
          enabled = function()
            return in_git and vim.o.columns > 130
          end,
          padding = 1,
          -- ttl = 5 * 60,
        }, cmd)
      end, cmds)
    end,
  },
}
