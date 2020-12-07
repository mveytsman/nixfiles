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

  # Common networking
  networking.extraHosts = ''
    155.138.147.72 marquez
    192.168.2.15 vidal
  '';
  
  fileSystems."/mnt/vidal/includesec" = {
      device = "//vidal/includesec";
      fsType = "cifs";
      options = let
        permissions_opts = "uid=1000,gid=100";
        # this line prevents hanging on network split
        automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
        credentials_opts = "credentials=/etc/nixos/secrets/smb_secrets";
      in ["${permissions_opts},${automount_opts},${credentials_opts}"];
  };

  networking.nameservers = [ "1.1.1.1" ];

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "20.03"; # Did you read the comment?
}
