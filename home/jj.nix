{
  userVars,
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.magic.jjModule;
in {
  options.magic.jjModule = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable jj module";
    };
    userName = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = userVars.gitUsername;
      description = "JJ username";
    };
    userEmail = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = userVars.gitEmail;
      description = "JJ user email";
    };

    home.file.".jj/config.toml".text = ''
      [ui]
      diff-editor = ["nvim", "-c", "DiffEditor $left $right $output"]
    '';
    home.packages = with pkgs; [
      lazyjj
      meld
    ];
    programs = {
      jujutsu = {
        enable = true;
        settings = {
          user = {
            email = "sawyerjr.25@gmail.com";
            name = "TSawyer87";
          };
          ui = {
            default-command = [
              "status"
              "--no-pager"
            ];
            diff-editor = ":builtin";
            merge-editor = ":builtin";
          };
        };
      };
    };
  };
}
