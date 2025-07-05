## profiles

- Core:

  - No:
    - LaTex integration or pdf viewer
    - CMP plugins
    - English spelling dictionary
    - Nerd Font Icon integration
  - Values for <profile> include default and core

- Full:
  - Everything including stuff left out in core
  - Found in `inputs.nix-vim.packages.${system}.full`
  - Values for <profile> include full

## Usage

- You can test it on your system with `nix run github:Chucklee1/nix-vim <optionally specify profile>`
- If you do not have a flake-based setup, see <https://nixos.wiki/wiki/flakes> for how to properly run or use this

- Using as a flake package:
  1: Put the following under

  ```nix
  nix-vim.url = "github:Chucklee1/nix-vim";
  ```

  2A: Adding as a direct package:

  ```nix
      # or home.packages if using home-manager
      environment.systemPackage = [inputs.nix-vim.packages.${pkgs.system}.<profile>];
  ```

  2B: Adding as an overlay (recommended):

  ```nix
      # all profile instances are under the default overlay
      nixpkgs.overlays = [inputs.nixvim.overlays.default];

      environment.systemPackages = [pkgs.nixvim.<profile>]
  ```
