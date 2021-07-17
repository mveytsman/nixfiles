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
  # https://www.reddit.com/r/Trackballs/comments/n9bg2d/so_i_wanted_to_use_inertia_scroll/
  # this still doesn't- work :(
  services.xserver.inputClassSections = [''
    Identifier "Kensington Slimblade Trackball"
    #MatchVendor "Kensington"
    #MatchProduct "SlimBlade Trackball"
    MatchIsPointer "on"
   
    #Driver       "libinput"
    Option "SendCoreEvents" "true"
    Option "ButtonMapping" "3 2 1 4 5 6 7 2"
    Option "EmulateWheel" "false"
    Option "EmulateWheelButton" "0"
    Option "EmulateWheelInertia" "30"
    #Option "DragLockButtons" "2 1"
    Option "XAxisMapping" "6 7"
    Option "YAxisMapping" "4 5"
    Option "AccelerationProfile" "2"
    Option "AccelerationThreshold" "0"
    Option "AccelerationNumerator" "34"
    Option "AccelerationDenominator" "12"
    Option "AdaptiveDeceleration" "3"
    Option "VelocityScale" "2"
  ''];
  networking.hostName = "caro"; # Define your hostname.

  networking.networkmanager.enable = true;
}
