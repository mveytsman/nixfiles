# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
       ../common/boot.nix
    ../common/desktop.nix
    ../common/system.nix
    ../common/users.nix
      ../hardware/thinkpad-yogax1.nix
    ];

  networking.hostName = "conrad"; # Define your hostname.

  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.macAddress = "random";
}
