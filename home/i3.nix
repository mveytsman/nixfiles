{ config, lib, pkgs, ... }:

let mod = "Mod4";
in {
  xsession.enable = true;
  xsession.windowManager.i3 = {
    enable = true;

    configFile = "/etc/nixos/home/config/i3/config";
  };
} 
