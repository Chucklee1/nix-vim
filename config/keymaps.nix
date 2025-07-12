{
  globals.mapleader = " ";
  globals.maplocalleader = " ";
  extraConfigLua = ''
    local key = vim.keymap.set
    -- General
    key("n", "<esc>",      ":nohlsearch<CR>", {desc = "Clear search highlights"})
    key("n", "<leader>e",  ":Yazi<CR>",       {desc = "Open fil editor"})
    key("n", "<leader>gg", ":LazyGit<CR>",    {desc = "Open LazyGit"})

    -- Telescope binding
   key("n", "<leader>fb", ":Telescope buffers<CR>",    {desc = ""})
   key("n", "<leader>ff", ":Telescope find_files<CR>", {desc = ""})
   key("n", "<leader>fg", ":Telescope live_grep<CR>",  {desc = ""})
   key("n", "<leader>fn", ":Telescope nerdy<CR>",      {desc = ""})

    -- Buffer
    key("n",  "<S-l>",      "bn",  {desc = ""})
    key("n",  "<S-h>",      "bp",  {desc = ""})
    key("n",  "<leader>c",  "bd",  {desc = ""})

    -- use the force
    key("n", "<leader>W",  "w!",  {desc = ""})
    key("n", "<leader>Q",  "q!",  {desc = ""})
    key("n",  "<leader>c", "bd",  {desc = ""})
    key("n", "<leader>C",  "bd!", {desc = ""})

    -- tweaks 
    key("n", "n", "nzzzv", { desc = "Next search result (centered)" })
    key("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })
    key("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
    key("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })

    key("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
    key("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
    key("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
    key("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

    key("v", "<", "<gv", { desc = "Indent left and reselect" })
    key("v", ">", ">gv", { desc = "Indent right and reselect" })

    key("n", "J", "mzJ`z", { desc = "Join lines and keep cursor position" })
  '';
  keymaps = let
    mkKeymaps = mode: type: list:
      map (sublist:
        {
          inherit mode;
          key = builtins.elemAt sublist 1;
        }
        // (
          if type == "wrap"
          then {action = "<cmd>${builtins.elemAt sublist 0}<CR>";}
          else if type == "raw"
          then {
            action.__raw = builtins.elemAt sublist 0;
            options.desc = builtins.elemAt sublist 2;
          }
          else {}
        ))
      list;
  in
    builtins.concatLists [
      (mkKeymaps "n" "wrap"


        ])
      # toggles - credit to Khaneliman's khanelivim
      (mkKeymaps "n" "raw" [
        [
          # lua
          ''
            function ()
              vim.b.disable_diagnostics = not vim.b.disable_diagnostics
              if vim.b.disable_diagnostics then
                vim.diagnostic.disable(0)
              else
                vim.diagnostic.enable(0)
              end
              vim.notify(string.format("Buffer Diagnostics %s", bool2str(not vim.b.disable_diagnostics), "info"))
            end''
          "<leader>ud"
          "local diagnostics toggle"
        ]
        [
          # lua
          ''
            function ()
              vim.g.disable_diagnostics = not vim.g.disable_diagnostics
              if vim.g.disable_diagnostics then
                vim.diagnostic.disable()
              else
                vim.diagnostic.enable()
              end
              vim.notify(string.format("Global Diagnostics %s", bool2str(not vim.g.disable_diagnostics), "info"))
            end''
          "<leader>uD"
          "Global diagnostics toggle"
        ]

        [
          # lua
          ''
            function ()
              vim.cmd('FormatToggle!')
              vim.notify(string.format("Buffer Autoformatting %s", bool2str(not vim.b[0].disable_autoformat), "info"))
            end''
          "<leader>uf"
          "local autoformatting toggle"
        ]

        [
          # lua
          ''
            function ()
              vim.cmd('FormatToggle')
              vim.notify(string.format("Global Autoformatting %s", bool2str(not vim.g.disable_autoformat), "info"))
            end''
          "<leader>uF"
          "Global autoformatting toggle"
        ]

        [
          # lua
          ''
            function ()
              if vim.g.spell_enabled then vim.cmd('setlocal nospell') end
              if not vim.g.spell_enabled then vim.cmd('setlocal spell') end
              vim.g.spell_enabled = not vim.g.spell_enabled
              vim.notify(string.format("Spell %s", bool2str(vim.g.spell_enabled), "info"))
            end''
          "<leader>us"
          "Spell toggle"
        ]

        [
          # lua
          ''
            function ()
              vim.wo.wrap = not vim.wo.wrap
              vim.notify(string.format("Wrap %s", bool2str(vim.wo.wrap), "info"))
            end''
          "<leader>uw"
          "Word Wrap toggle"
        ]
      ])
    ];
}
