{ pkgs, ... }:
{
  imports = [];

  services.xserver.enable = true;
  services.xserver.xkbOptions = "grp:alt_space_toggle, ctrl:nocaps";
  
  services.xserver.windowManager.i3.enable = true;
  services.xserver.libinput.enable = true;

  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.macAddress = "random";
	
  i18n = {
    consoleFont = "${pkgs.terminus_font}/share/consolefonts/ter-u28n.psf.gz";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };
 

  sound.enable = true;
 
  environment.systemPackages = with pkgs; [
    i3status-rust
    rofi
    clipmenu
    clipnotify

    networkmanagerapplet

    firefox
    kitty
    vim
    emacs
    git
    cmake
  ];

  # flatpak  
  services.flatpak.enable = true;
  services.flatpak.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  services.clipmenu.enable = true;
  # Based on https://github.com/cdown/clipmenu/blob/develop/init/clipmenud.service
  systemd.user.services.clipmenud = {
    description = "Clipmenu daemon";
    serviceConfig =  {
      Type = "simple";
      NoNewPrivileges = true;
      ProtectControlGroups = true;
      ProtectKernelTunables = true;
      RestrictRealtime = true;
      MemoryDenyWriteExecute = true;
    };
    wantedBy = [ "default.target" ];
    environment = {
      DISPLAY = ":0";
    };
    path = [ pkgs.clipmenu ];
    script = ''
      ${pkgs.clipmenu}/bin/clipmenud
    '';
  };

  fonts.fonts = with pkgs; [
    dejavu_fonts
    terminus
    nerdfonts  # Includes font-awesome, material-icons, powerline-fonts
    emojione
  ];

  environment.sessionVariables.TERMINAL = [ "kitty" ];
}
