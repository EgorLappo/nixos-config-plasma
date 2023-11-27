{ config, pkgs, ... }:

let
  username = "egor";
  homeDirectory = "/home/${username}";
  configHome = "${homeDirectory}/.config";

  defaultPkgs = with pkgs; [
    any-nix-shell # fish support for nix shell
    bottom # alternative to htop & ytop
    drawio # diagram design
    duf # disk usage/free utility
    erdtree # a better `tree`
    eza # a better `ls`
    fd # "find" for files
    feh # images
    gh # github cli
    git-lfs
    glow # terminal markdown viewer
    killall # kill processes by name
    lnav # log file navigator on the terminal
    betterlockscreen # fast lockscreen based on i3lock
    ncdu # disk space info (a better du)
    nitch # minimal system information fetch
    nitrogen # wallpaper setter
    nix-index # locate packages containing certain nixpkgs
    nix-init # initialize nix projects
    nix-output-monitor # nom: monitor nix commands
    nixpkgs-fmt # format nix files
    nurl # nix url prefetcher
    ouch # painless compression and decompression for your terminal
    pavucontrol # pulseaudio volume control
    paprefs # pulseaudio preferences
    pasystray # pulseaudio systray
    prettyping # a nicer ping
    ranger # terminal file explorer
    ripgrep # fast grep
    scrot # screenshots
    tldr # summary of a man page
    tree # display files in a tree view
    vlc # media player
    xsel # clipboard support (also for neovim)
    wget

    # haskell packages
    haskellPackages.nix-tree # visualize nix dependencies

    # python
    micromamba
  ];
in
{
  imports = [
    ./programs
  ];

  programs.home-manager.enable = true;

  xdg = {
    inherit configHome;
    enable = true;
  };

  home = {
    inherit username homeDirectory;
    stateVersion = "23.05";

    packages = defaultPkgs;

    sessionVariables = {
      EDITOR = "HELIX";
      MACHINE = "lab-dell";
    };
  };

  # restart services on change
  systemd.user.startServices = "sd-switch";

  # notifications about home-manager news
  news.display = "silent";

}
