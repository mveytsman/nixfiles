{ python3, ... }:

let
  localPython = python3.override {
    packageOverrides = self: super: {
      # Packages that aren't in nixpkgs so we need to build them
      rollbar = super.buildPythonPackage rec {
        pname = "rollbar";
        version = "0.13.18";

        src = super.fetchPypi {
          inherit pname version;
          sha256 = "1vb18jj7fi65la1zrfbgjd20g81fqmsfp4dhdqq552rsl5zfld7q";
        };
        buildInputs = with self; [ requests ];

        doCheck = false;
      };

      pytest = super.pytest.overridePythonAttrs (oldAttrs: rec {
        # tests for pytest itself are failing for me :(
        doCheck = false;
      });

      # These packages are locked to versions that aren't the latest in nixpkgs, so we need to fetch the downgraded versions
      click = super.click.overridePythonAttrs (oldAttrs: rec {
        version = "6.7";
        src = oldAttrs.src.override {
          inherit version;
          sha256 = "02qkfpykbq35id8glfgwc38yc430427yd05z1wc5cnld8zgicmgi";
        };
        postPatch = "";
        doCheck = false;
      });

      pygments = super.pygments.overridePythonAttrs (oldAttrs: rec {
        version = "2.2.0";
        src = oldAttrs.src.override {
          inherit version;
          sha256 = "1k78qdvir1yb1c634nkv6rbga8wv4289xarghmsbbvzhvr311bnv";
        };
        doCheck = false;
      });

      requests = super.requests.overridePythonAttrs (oldAttrs: rec {
        version = "2.20.0";
        src = oldAttrs.src.override {
          inherit version;
          sha256 = "033p8ax4qs81g0c95ngincm52q84g1xnlazk4vjzdjhpxfmgvp4r";
        };
        doCheck = false;
      });

      stripe = super.stripe.overridePythonAttrs (oldAttrs: rec {
        version = "1.51.0";
        src = oldAttrs.src.override {
          inherit version;
          sha256 = "088xv7xg1a1mdsplsxl4zjdh0agmf3zf7r4y07yl8v2c7887w2f9";
        };
      });

      urllib3 = super.urllib3.overridePythonAttrs (oldAttrs: rec {
        version = "1.24.3";
        src = oldAttrs.src.override {
          inherit version;
          sha256 = "1x0slqrv6kixkbcdnxbglvjliwhc1payavxjvk8fvbqjrnasd4r3";
        };
        doCheck = false;
      });

      idna = super.idna.overridePythonAttrs (oldAttrs: rec {
        version = "2.7";
        src = oldAttrs.src.override {
          inherit version;
          sha256 = "05jam7d31767dr12x0rbvvs8lxnpb1mhdb2zdlfxgh83z6k3hjk8";
        };
        doCheck = false;
      });
    };
  };

in python3.pkgs.buildPythonApplication rec {
  pname = "gigalixir";
  version = "1.1.9";

  src = python3.pkgs.fetchPypi {
    inherit pname version;
    sha256 = "1gxx411qkyd330v7sam8nlikhxj0dn2a9ca1gwkckscibbpa47ra";
  };

  propagatedBuildInputs = with localPython.pkgs; [
    setuptools
    click
    pygments
    requests
    stripe
    rollbar
  ];

  postPatch = ''
    # pytest-runner is deprecated, and we won't use it
    substituteInPlace setup.py --replace "'pytest-runner'," ""
  '';

  doCheck = false;
}
