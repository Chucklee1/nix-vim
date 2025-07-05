{
  lib,
  profile,
  ...
}:
with lib;
  mkIf (profile == "core") {
    services.nixvim = {
      cmp.enable = false;
    };
  }
  // mkIf (profile == "full") {
    services.nixvim = {
      cmp.enable = true;
    };
  }
