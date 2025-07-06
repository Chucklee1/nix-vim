{
  lib,
  profile,
  ...
}:
with lib; {
  services.nixvim =
    mkIf (profile == "core") {
      telescope.enable = true;
    }
    // mkIf (profile == "full") {
      cmp.enable = true;
      latex.enable = true;
      telescope.enable = true;
      telescope.nerdIconLookup = true;
    };
}
