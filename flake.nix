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
          name = "orca-slicer";
          src = pkgs.fetchurl {
            url = "https://github.com/SoftFever/OrcaSlicer/releases/download/v2.2.0/OrcaSlicer_Linux_V2.2.0.AppImage";
            #sha256 = "sha256-h+cHWhrp894KEbb3ic2N4fNTn13WlOSYoMsaof0RvRI="; # Replace with actual hash
            sha256 = "sha256-3uqA3PXTrrOE0l8ziRAtmQ07gBFB+1Zx3S6JhmOPrZ8="; # Replace with actual hash
          };

          extraPkgs = ps: with ps; [
            cacert
            curl
            glib
            glib-networking
            gst_all_1.gst-plugins-bad
            gst_all_1.gst-plugins-base
            gst_all_1.gst-plugins-good
	    gst_all_1.gstreamer
            #webkitgtk
	    webkitgtk_6_0
	    webkitgtk_4_0
	    wxGTK32
          ];
#	  system.replaceRuntimeDependencies = [
#            ({ original = pkgs.mesa; replacement = unstable.mesa; })
#            ({ original = pkgs.mesa.drivers; replacement = mesa.drivers; })
#          ];
          profile = ''
            export SSL_CERT_FILE="${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt"
            export GIO_MODULE_DIR="${pkgs.glib-networking}/lib/gio/modules/"
          '';

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

