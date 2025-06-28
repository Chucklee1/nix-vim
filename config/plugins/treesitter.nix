{
  pkgs,
  profile,
  ...
}: {
  plugins = {
    treesitter = {
      enable = true;
      settings = {
        highlight = {
          enable = true;
          disable =
            if profile == "full"
            then ["latex"]
            else [];
        };
        incremental_selection.enable = true;
      };
    };
  };

  extraPackages = with pkgs; [tree-sitter];
}
