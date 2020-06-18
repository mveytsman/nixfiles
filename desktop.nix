{ pkgs, ... }:
{
  imports = [];

  services.xserver.enable = true;
  services.xserver.xkbOptions = "grp:alt_space_toggle, ctrl:nocaps";
  
  services.xserver.windowManager.i3.enable = true;
  services.xserver.libinput.enable = true;

  services.colord.enable = true;

  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.macAddress = "random";

  console.font = "${pkgs.terminus_font}/share/consolefonts/ter-u28n.psf.gz";
  console.keyMap = "us";
  i18n.defaultLocale = "en_US.UTF-8";

  sound.enable = true;
  
  hardware.sane.enable = true;
  hardware.pulseaudio = {
    enable = true;
    # Need full for bluetooth support
    package = pkgs.pulseaudioFull;
    extraModules = [ pkgs.pulseaudio-modules-bt ];
  };

  # flatpak  
  xdg.portal.enable = true;
  services.flatpak.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  services.accounts-daemon.enable = true; # Required for flatpak+xdg
  
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

  environment.sessionVariables.TERMINAL = [ "alacritty" ];
}
