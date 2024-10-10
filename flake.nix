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
          url = "https://github.com/SoftFever/OrcaSlicer/releases/download/1.6.2-beta/OrcaSlicer-1.6.2-beta-linux-x64-20231010.AppImage";
          sha256 = "1hc6pn25p6i3b8idjhsszdfv9i8khclx2a9plk5x2f0v5bf5d5fz"; # Replace with actual hash
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
          libX11
          libXext
          libXinerama
          libXrandr
          libXcursor
          libXdamage
          libXcomposite
          libXfixes
          libXi
          libXtst
          fontconfig
          freetype
          libpng
          libxcb
          libxkbcommon
          mesa
          dbus
          at-spi2-atk
          at-spi2-core
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
