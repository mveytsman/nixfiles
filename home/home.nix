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

  nixpkgs.overlays = [ (import ./overlays/burppro.nix) (import ./overlays/standardnotes.nix)];

  home.packages = with pkgs; [
    i3status-rust
    upower
    rofi
    clipmenu
    clipnotify
    maim
    xclip

    # programming
    ag
    alacritty
    vim
    emacs
    vscode
    cmake
    nixfmt

    # security
    burppro

    # browser & apps
    firefox-bin
    google-chrome
    brave
    evince
    discord
    slack
    zulip
    bitwarden
    standardnotes

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

  # setup vscode for live share
  imports = [
    #./i3.nix
    "${
      fetchTarball "https://github.com/msteen/nixos-vsliveshare/tarball/master"
    }/modules/vsliveshare/home.nix"
  ];

  services.vsliveshare = {
    enable = true;
    extensionsDir = "$HOME/.vscode/extensions";
    nixpkgs = fetchTarball
      "https://github.com/NixOS/nixpkgs/tarball/61cc1f0dc07c2f786e0acfd07444548486f4153b";
  };

}
