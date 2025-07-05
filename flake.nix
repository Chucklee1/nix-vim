{
  description = "Personal config for nixvim";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixvim.url = "github:nix-community/nixvim";
    customLib.url = "github:Chucklee1/nixos-dotfiles";
    flake-parts.url = "github:hercules-ci/flake-parts";
    en_us-dictionary.url = "github:dwyl/english-words";
    en_us-dictionary.flake = false;
  };

  outputs = {self, ...} @ inputs: let
    inherit (inputs.customLib) extlib;
    # function definitions are under the repo's root at libs.nix
  in
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

        # ---- module definition ----
        nixvimModule = profile: {
          # profile choices: core, full
          inherit system;
          module.imports = extlib.simpleMerge "${self}/config";
          extraSpecialArgs = {inherit inputs extlib profile;};
        };
      in {
        formatter = pkgs.alejandra;
        checks = {
          default = nixvimLib.check.mkTestDerivationFromNixvimModule (nixvimModule "core");
          full = nixvimLib.check.mkTestDerivationFromNixvimModule (nixvimModule "full");
        };
        packages = {
          default = nixvim'.makeNixvimWithModule (nixvimModule "core");
          full = nixvim'.makeNixvimWithModule (nixvimModule "full");
        };
      };
    };
}
