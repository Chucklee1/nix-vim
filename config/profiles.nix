{
  lib,
  profile,
  ...
}:
with lib; {
  services.nixvim =
    mkIf (profile == "core") {}
    // mkIf (profile == "full") {
      services.nixvim = {
        cmp.enable = true;
        latex.enable = true;
        telescope.nerdIcons = true;
      };
    };
}
