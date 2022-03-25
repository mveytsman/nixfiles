{ pkgs, ... }: {
  imports = [ ];
  nix = {
    package = pkgs.nixFlakes; # or versioned attributes like nix_2_7
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
  services.xserver = {
    enable = true;
    xkbOptions = "grp:alt_space_toggle, ctrl:nocaps";
    desktopManager.xfce = {
      enable = true;
      noDesktop = true;
      enableXfwm = true;
    };
    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
    };
    libinput = {
      enable = true;
    };
  };
  services.colord.enable = true;
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
  
  services.redshift = {
    enable = true;
   
    temperature = {
      day = 5700;
      night = 3500;
    };

    brightness = {
      day = "1.0";
      night = "0.7";
    };
  };
  
  location = {
    #provider = "geoclue2";
    provider = "manual";
    latitude = 43.65;
    longitude = -79.38;
  };
    
  fonts.fonts = with pkgs; [
    dejavu_fonts
    nerdfonts # Includes font-awesome, material-icons, powerline-fonts
    emojione
  ];

  environment.sessionVariables.TERMINAL = [ "alacritty" ];
}
