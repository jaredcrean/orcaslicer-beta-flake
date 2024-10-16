{
  description = "Nix flake for packaging OrcaSlicer from AppImage";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
  };

  outputs = { self, nixpkgs }: 
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };
    in {
      packages = {
        x86_64-linux = pkgs.appimageTools.wrapType2 {
          name = "orca-slicer-beta";
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
            glibcLocales
            cairo
            cairomm
            gdk-pixbuf
            glew
            glfw
            gmp
            libavif
            glib-networking
            gst_all_1.gstreamer
            gst_all_1.gst-libav
            gst_all_1.gst-plugins-base
            gst_all_1.gst-plugins-bad
            gst_all_1.gst-plugins-ugly
            gst_all_1.gst-plugins-good
            gtest
            gtk3
            hicolor-icon-theme
            ilmbase
            fontconfig
            freetype
            libpng
            mesa
            dbus
            at-spi2-atk
            at-spi2-core
            webkitgtk
            cacert
          ];

          extraEnv = {
            SSL_CERT_FILE = "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt";
            SSL_CERT_DIR = "${pkgs.cacert}/etc/ssl/certs";
          };

          meta = with pkgs.lib; {
            description = "Orca Slicer 3D printer software";
            homepage = "https://github.com/SoftFever/OrcaSlicer";
            license = licenses.gpl3Plus;
            platforms = platforms.linux;
          };
        };
      };

      defaultPackage.x86_64-linux = self.packages.x86_64-linux;
    };
}

