{
  description = "Personal config for nixvim";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixvim.url = "github:nix-community/nixvim";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = {self, ...} @ inputs:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      perSystem = {
        pkgs,
        system,
        ...
      }: let
        # ---- lib & pkgs ----
        nixvimLib = inputs.nixvim.lib.${system};
        nixvim' = inputs.nixvim.legacyPackages.${system};
        # init copied from my nixos-dotfiles repo
        extlib = import "${self}/libs.nix" {inherit (inputs) nixpkgs;};

        # ---- module definition ----
        nixvimModule = type: {
          inherit system;
          module.imports = extlib.simpleMerge "${self}/config";
          extraSpecialArgs = {inherit extlib type;};
        };
        nvim = nixvim'.makeNixvimWithModule nixvimModule;
      in {
        inherit extlib;
        formatter = pkgs.alejandra;
        checks.default = nixvimLib.check.mkTestDerivationFromNixvimModule nixvimModule;
        packages.default = nvim;
      };
    };
}
