{ config, pkgs, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../common/boot.nix
    ../../common/desktop.nix
    ../../common/system.nix
    ../../common/users.nix
  ];

  hardware.opengl.extraPackages = with pkgs; [
    vaapiIntel
    libvdpau-va-gl
    vaapiVdpau
  ];

  # Hardware specific
  hardware.cpu.intel.updateMicrocode = true;
  hardware.enableRedistributableFirmware = true;
  hardware.steam-hardware.enable = true; # VR
  services.xserver.videoDrivers = [ "nvidia" ];
  services.fwupd.enable = true;
  hardware.opengl.driSupport32Bit = true;

  # Set up for my multimonitor situation
  services.xserver.screenSection = ''
    Option         "metamodes" "DVI-D-0: nvidia-auto-select +0+0 {rotation=right, ForceCompositionPipeline=On}, DP-0: nvidia-auto-select +1440+200 {ForceCompositionPipeline=On, ForceFullCompositionPipeline=On}"
  '';

  # Set up the trackball
  services.xserver.inputClassSections = [''
        Identifier      "Trackball"
        MatchProduct    "Kensington Expert Mouse"
        Driver          "evdev"
        Option          "ZAxisMapping"          "4 5"
        # four real buttons and the scroll wheel:
        Option          "Buttons"               "8"
        Option          "ButtonMapping"         "1 8 3 4 5 2 8 9"
  ''];
  networking.hostName = "caro"; # Define your hostname.
}
