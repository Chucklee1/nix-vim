## Usage

- You can test it on your system with `nix run github:Chucklee1/nix-vim`
- If you do not have a flake-based setup, see <https://nixos.wiki/wiki/flakes> for how to properly run or use this

- If you want to import my flake, add it to your flake inputs with `inputs.nixvim.url = "github:Chucklee/nixos-dotfiles";`

- Then add it as a package in your configuration as `inputs.nixvim.packages.${pkgs.system}.default`

## profiles

- Core: No LaTex integration or pdf viewer
- Full: Everything including stuff left out in core
