{
  description = "flake for building slstatus";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };

    in
    {
      packages.${system}.default = pkgs.stdenv.mkDerivation {
        pname = "slstatus";
        version = "1.1";
        src = ./.;

        nativeBuildInputs = [ pkgs.pkg-config ];
        buildInputs = [
          pkgs.libX11
          pkgs.libxcb
          pkgs.libXau
          pkgs.libXdmcp
        ];

        makeFlags = [
          "PREFIX=$(out)"
          "CC:=$(CC)"
        ];

      };
    };
}
