let hashedPassword = import ./.hashedPassword.nix; in # echo "\"$(mkpasswd -m sha-512)\"" > .hashedPassword.nix; chmod 400 .hashedPassword.nix
# make sure it's in gitignore!!

{ config, pkgs, lib, ... }:

{
  users.users.maxim = {
  isNormalUser = true;
  home = "/home/maxim";
  description = "maxim";
  extraGroups = [ "wheel" "sudoers" "audio" "video" "disk" "networkmanager" "plugdev"];
  uid = 1000;
  hashedPassword = hashedPassword;
  };

}
