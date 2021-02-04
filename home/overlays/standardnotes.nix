self:
{ stdenv, appimageTools, autoPatchelfHook, desktop-file-utils, fetchurl
, runtimeShell, libsecret, gtk3, gsettings-desktop-schemas, ... }: {

  standardnotes = let
    version = "3.5.16";
    pname = "standardnotes";
    name = "${pname}-${version}";

    plat = {
      i386-linux = "-i386";
      x86_64-linux = "x86_64";
    }.${stdenv.hostPlatform.system};

    sha256 = {
      i386-linux = "1s2acf2ai83h8x668px4alml8adrc91sdbgqjbswl16dl9sslzl6";
      x86_64-linux = "0aq4ppmax4b3myzhph8ndb9500kjy8h77lj3wsndwy7blcfadxsy";
    }.${stdenv.hostPlatform.system};

    src = fetchurl {
      url =
        "https://github.com/standardnotes/desktop/releases/download/v${version}/standard-notes-${version}-linux-${plat}.AppImage";
      inherit sha256;
    };

    appimageContents = appimageTools.extract { inherit name src; };

    nativeBuildInputs = [ autoPatchelfHook desktop-file-utils ];

  in appimageTools.wrapType2 rec {
    inherit name src;

    profile = ''
      export XDG_DATA_DIRS=${gsettings-desktop-schemas}/share/gsettings-schemas/${gsettings-desktop-schemas.name}:${gtk3}/share/gsettings-schemas/${gtk3.name}:$XDG_DATA_DIRS
    '';

    extraPkgs = pkgs: with pkgs; [ libsecret ];

    extraInstallCommands = ''
      # directory in /nix/store so readonly
      cp -r  ${appimageContents}/* $out
      cd $out
      chmod -R +w $out
      mv $out/bin/${name} $out/bin/${pname}

      # fixup and install desktop file
      ${desktop-file-utils}/bin/desktop-file-install --dir $out/share/applications \
        --set-key Exec --set-value ${pname} standard-notes.desktop

      rm usr/lib/* AppRun standard-notes.desktop .so*
    '';

    meta = with stdenv.lib; {
      description = "A simple and private notes app";
      longDescription = ''
        Standard Notes is a private notes app that features unmatched simplicity,
        end-to-end encryption, powerful extensions, and open-source applications.
      '';
      homepage = "https://standardnotes.org";
      license = licenses.agpl3;
      maintainers = with maintainers; [ mgregoire ];
      platforms = [ "i386-linux" "x86_64-linux" ];
    };
  };
}
