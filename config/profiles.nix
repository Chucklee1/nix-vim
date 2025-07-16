{
  lib,
  profile,
  ...
}:
with lib; {
  services.nixvim =
    mkIf (profile == "core") {
      formatting.enable = false;
      telescope.enable = true;
    }
    // mkIf (profile == "full") {
      cmp.enable = true;
      formatting.enable = true;
      formatting.autoFormat = false;
      latex.enable = true;
      telescope.enable = true;
      telescope.nerdIconLookup = true;
    };
}
