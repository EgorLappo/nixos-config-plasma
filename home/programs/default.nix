{ config, pkgs, ... }: 

let
  more = { pkgs, ... }: {
    programs = {
      aria2.enable = true;

      atuin.enable = true;

      bat.enable = true;

      broot = {
        enable = true;
        enableFishIntegration = true;
      };

      direnv = {
        enable = true;
        nix-direnv.enable = true;
      };

      fzf = {
        enable = true;
        enableFishIntegration = true;
        defaultCommand = "fd --type file --follow"; # FZF_DEFAULT_COMMAND
        defaultOptions = [ "--height 20%" ]; # FZF_DEFAULT_OPTS
        fileWidgetCommand = "fd --type file --follow"; # FZF_CTRL_T_COMMAND
      };

      gpg.enable = true;

      htop = {
        enable = true;
        settings = {
          sort_direction = true;
          sort_key = "PERCENT_CPU";
        };
      };

      jq.enable = true;

      mpv = {
        enable = true;
        scripts = [ pkgs.mpvScripts.mpris ];
      };

      ssh.enable = true;

      zoxide = {
        enable = true;
        enableFishIntegration = true;
        options = [ ];
      };

    };
  };
in { 

  imports = [
  ./alacritty
  # ./browsers/firefox.nix
    ./browsers/chromium.nix
    ./git
    ./fish
    ./helix
    ./neofetch
    ./neovim-ide
    ./ngrok
    ./rofi
    ./tmux
    ./zathura
    more
  ];
}
