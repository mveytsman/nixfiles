{ pkgs, config, ... }:

{

 #nix.nixPath = [
 #   "nixos-config=/etc/nixos/hosts/${config.networking.hostName}/default.nix"
 # ];
  environment.systemPackages = with pkgs; [ silver-searcher home-manager ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable docker
  virtualisation.docker.enable = true;

  # Timezone
  time.timeZone = "America/Toronto";

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "20.03"; # Did you read the comment?
}
