{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "20.09";
  
  # TODO can we pull these out of users.nix?
  home.username = "maxim";
  home.homeDirectory = "/users/maxim";


  nixpkgs.overlays = [ (import ./overlays/burppro.nix) (import ./overlays/standardnotes.nix)];

  home.packages = with pkgs; [
    i3status-rust
    lm_sensors
    upower
    rofi
    maim
    xclip

    # programming
    silver-searcher
    alacritty
    vim
    emacs
    vscode-with-extensions.override { vscodeExtensions = with vscode-extensions; [ ms-vsliveshare.vsliveshare ]; }
    cmake
    nixfmt

    # security
    burppro

    # browser & apps
    firefox-bin
    google-chrome
    brave
    evince
    bitwarden

    # chat
    discord
    slack
    zulip
    zoom-us
    
    # organization
    standardnotes
    obsidian
    logseq

    # utilities
    lxrandr
    pavucontrol
    networkmanagerapplet

    # games
    steam-run
  ];

  programs.git = {
    enable = true;
    userEmail = "maxim@ontoillogical.com";
    userName = "Max Veytsman";
  };

  # config
  home.file.".config/i3/config".source = ./config/i3/config;
  home.file.".config/i3//i3status-rs.toml".source = ./config/i3/i3status-rs.toml;
}
