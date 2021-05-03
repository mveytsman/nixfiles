let hashedPassword = import ../secrets/hashedPassword.nix; in 
{ config, pkgs, lib, ... }:

{
  users.users.maxim = {
    isNormalUser = true;
    home = "/home/maxim";
    description = "maxim";
    extraGroups = [ "wheel" "audio" "video" "disk" "networkmanager" "plugdev" "docker"];
    uid = 1000;
    hashedPassword = hashedPassword;
  };
}
