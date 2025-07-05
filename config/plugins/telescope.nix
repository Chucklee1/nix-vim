{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.services.nixvim.telescope;
in {
  options.services.nixvim.telescope = {
    enable = mkEnableOption {
      description = "enables telescope";
      default = true;
    };
    nerdIcons = mkEnableOption {
      description = "enable support for nerd icon searching via telescope";
      default = false;
    };
  };
  config =
    mkIf cfg.enable {
      plugins.telescope = {
        enable = true;
        settings = {
          defaults.mappings = {
            i = {"<C-d>".__raw = "require('telescope.actions').delete_buffer";};
            n = {"<C-d>".__raw = "require('telescope.actions').delete_buffer";};
          };
        };
        extensions = {
          manix.enable = true;
          fzf-native.enable = true;
          media-files = {
            enable = true;
            settings.filetypes = [
              "png"
              "jpg"
              "webm"
              "gif"
              "mp4"
              "mov"
              "mkv"
              "pdf"
              "epub"
            ];
          };
        };
      };
    }
    // mkIf config.plugins.lazygit.enable {
      extraConfigLua = "require('telescope').load_extension('lazygit')";
    }
    // mkIf cfg.nerdIcon {
      plugins.nerdy = {
        enable = true;
        enableTelescope = true;
      };
      extraConfigLua = "require('telescope').load_extension('nerdy')";
    };
}
