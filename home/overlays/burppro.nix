self:
{ stdenv, fetchurl, jre, runtimeShell, makeDesktopItem, ... }: {
  burppro = let
    version = "2020.11.3";
    product = "pro";
    executableName = "burpsuite";
    jar = fetchurl {
      name = "burpsuite.jar";
      url =
        "https://portswigger.net/Burp/Releases/Download?product=${product}&version=${version}&type=Jar";
      sha256 = "1dfl1nmvzyqgckr4ns84m3cma4yraj5h9fk21g2m6vgjlq2ajc0k";
    };
    launcher = ''
      #!${runtimeShell}
      exec ${jre}/bin/java -jar ${jar} "$@"
    '';

    desktopItem = makeDesktopItem {
      name = executableName;
      desktopName = "Burp Suite Professional";
      exec = executableName;
    };
  in stdenv.mkDerivation {
    pname = "burpsuite";
    inherit version;

    dontUnpack = true;
    dontConfigure = true;
    dontBuild = true;

    installPhase = ''
      mkdir -p $out/bin
      echo "${launcher}" > $out/bin/${executableName}
      chmod +x $out/bin/${executableName}
      mkdir -p $out/share/applications
      ln -s ${desktopItem}/share/applications/* $out/share/applications
    '';

    preferLocalBuild = true;

    meta = {
      description =
        "An integrated platform for performing security testing of web applications";
      longDescription = ''
        Burp Suite is an integrated platform for performing security testing of web applications.
        Its various tools work seamlessly together to support the entire testing process, from
        initial mapping and analysis of an application's attack surface, through to finding and
        exploiting security vulnerabilities.
      '';
      homepage = "https://portswigger.net/burp/";
      downloadPage = "https://portswigger.net/burp/freedownload";
      license = [ stdenv.lib.licenses.unfree ];
      platforms = jre.meta.platforms;
      hydraPlatforms = [ ];
      maintainers = with stdenv.lib.maintainers; [ bennofs ];
    };
  };
}

