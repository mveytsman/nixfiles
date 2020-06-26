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
    Option         "metamodes" "DVI-D-0: nvidia-auto-select +3840+0 {rotation=right, ForceCompositionPipeline=On}, DP-0: nvidia-auto-select +0+200 {ForceCompositionPipeline=On, ForceFullCompositionPipeline=On}"
  '';
  networking.hostName = "caro"; # Define your hostname.
}
