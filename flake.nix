{
  description = "Nix flake for packaging OrcaSlicer from AppImage";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    rec {
      packages.${system}.orcaslicer = pkgs.appimageTools.wrapType2 {
        name = "orcaslicer";
        src = pkgs.fetchurl {
          url = "https://github.com/SoftFever/OrcaSlicer/releases/download/v2.2.0-rc/OrcaSlicer_Linux_V2.2.0-rc.AppImage";
          sha256 = "sha256-cZbX2SVznoYqap6EW4SEGzGbp4ZUAytZMtN6juqW6fw="; # Replace with actual hash
        };

        extraPkgs = ps: with ps; [
          glibc
          zlib
          gtk3
          glib
          gtkmm3
          glibmm
          cairo
          cairomm
          gdk-pixbuf
          #          libX11
          #          libXext
          #          libXinerama
          #          libXrandr
          #          libXcursor
          #          libXdamage
          #          libXcomposite
          #          libXfixes
          #          libXi
          #          libXtst
          fontconfig
          freetype
          libpng
          #          libxcb
          #          libxkbcommon
          mesa
          dbus
          at-spi2-atk
          at-spi2-core
          webkitgtk
        ];

        meta = with pkgs.lib; {
          description = "Orca Slicer 3D printer software";
          homepage = "https://github.com/SoftFever/OrcaSlicer";
          license = licenses.gpl3Plus;
          platforms = platforms.linux;
        };
      };
    };
}
