{
  inputs = {
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
  };

  nixConfig = {
    substituters = [
      "https://cache.nixos.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    ];
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-parts,
      ...
    }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      perSystem =
        {
          pkgs,
          system,
          lib,
          ...
        }:
        {
          devShells.default =
            let
              pkgs = import nixpkgs {
                inherit system;
                config = {
                  allowUnfree = true;
                  android_sdk.accept_license = true;
                };
              };
              androidComposition = pkgs.androidenv.composeAndroidPackages {
                cmdLineToolsVersion = "latest";
                platformToolsVersion = "latest";
                buildToolsVersions = [ "36.0.0" "35.0.0" "34.0.0" "30.0.3" ];
                platformVersions = [
                  "36"
                  "35"
                  "34"
                  "33"
                  "31"
                ];
                includeCmake = true;
                cmakeVersions = [ "3.22.1" ];
                includeNDK = true;
                ndkVersions = [ "28.2.13676358" ];
              };
              androidSdk = androidComposition.androidsdk;
              PWD = builtins.getEnv "PWD";
            in
            pkgs.mkShell {
              CHROME_EXECUTABLE = lib.getExe pkgs.chromium;
              ANDROID_SDK_ROOT = "${androidSdk}/libexec/android-sdk";
              ANDROID_NDK_ROOT = "${androidSdk}/libexec/android-sdk/ndk-bundle";
              ANDROID_AVD_HOME = "${PWD}/.android/avd";
              ANDROID_HOME = "${androidSdk}/libexec/android-sdk";
              FLUTTER_SDK = "${pkgs.flutter}";
              GRADLE_OPTS = "-Dorg.gradle.project.android.aapt2FromMavenOverride=${androidSdk}/libexec/android-sdk/build-tools/34.0.0/aapt2 -Djava.net.preferIPv4Stack=true";
              LD_LIBRARY_PATH = "${PWD}/apps/onyx/build/linux/x64/debug/bundle/lib/:${PWD}/apps/onyx/build/linux/x64/release/bundle/lib/:${PWD}/apps/onyx/build/linux/x64/profile/bundle/lib/";
              buildInputs = with pkgs; [
                flutter_rust_bridge_codegen
                chromium
                flutter
                melos
                jdk25
                jdk17
                androidSdk
                at-spi2-core
                clang
                dart
                libdeflate
                xz
                zstd
                libwebp
                dbus
                util-linux
                cmake
                ninja
                libsecret
                android-tools
                pkg-config
                gtk3
                glib
                pcre2
                pcre
                libselinux
                libsepol
                libthai
                libdatrie
                libxdmcp
                libxkbcommon
                libxtst
                libepoxy
                libgcrypt
                libgpg-error
                apksigner
                zenity
                lerc
                libsysprof-capture
                just
              ];
            };
          formatter = pkgs.nixfmt-tree;
        };
    };
}
