{
  lib,
  profile,
  ...
}:
with lib; {
  services.nixvim =
    mkIf (profile == "core") {}
    // mkIf (profile == "full") {
      cmp.enable = true;
      latex.enable = true;
      nerdIconLookup = true;
    };
}
