self:
{ python3, ... }: {
  gigalixir = let
    mach-nix = import (builtins.fetchGit {
      url = "https://github.com/DavHau/mach-nix/";
      ref = "refs/tags/3.1.1";
    }) {
      # optionally bring your own nixpkgs
      # pkgs = import <nixpkgs> {};

      # optionally specify the python version
      # python = "python38";

      # optionally update pypi data revision from https://github.com/DavHau/pypi-deps-db
      # pypiDataRev = "some_revision";
      # pypiDataSha256 = "some_sha256";
      python = "python38";
    };
  in mach-nix.buildPythonApplication rec {
    src = "https://github.com/gigalixir/gigalixir-cli/archive/v1.2.0.tar.gz";
    requirementsExtra = "setuptools";
  };
}
