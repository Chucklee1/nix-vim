{ pkgs, ... }:
{
  # ---- LSP ----
  plugins.lsp.enable = true;
  lsp.servers = {
    asm_lsp.enable = true; # GAS/GO assembly
    bashls.enable = true;
    clangd.enable = true;
    html.enable = true;
    jdtls.enable = true;
    lemminx.enable = true; # xml
    lua_ls.enable = true;
    marksman.enable = true;
    nixd.enable = true;
  };

  # ---- FORMATTING ----
  plugins = {
    lsp-format.enable = true;
    none-ls = {
      enable = true;
      enableLspFormat = true;
      sources = {
        diagnostics.statix = {
          enable = true;
          settings.extra_args = [ "--disable=duplicate_key" ];
        };
        formatting = {
          alejandra.enable = true; # nix
          prettier.enable = true; # soyjack
          prettier.settings.disabled_filetypes = [ "html" ]; # tidy will cover html
          shfmt.enable = true;
          tidy.enable = true; # html, xhtml, xml
        };
      };
    };

    # ---- LANG QOL ----

    # color preview
    colorizer = {
      enable = true;
      settings.user_default_options.names = false;
    };

    # document tools
    render-markdown.enable = true;
  };

  extraPlugins = with pkgs.vimPlugins; [ plenary-nvim ];
  extraPackages = with pkgs; [
    alejandra
    lemminx # xml lsp
    stylua
    vscode-langservers-extracted # soyjack lsps
  ];
}
