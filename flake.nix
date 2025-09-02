{
  inputs = {
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
    nixpkgs-flutter-patched.url = "github:birros/nixpkgs?ref=flutter-335-fix-android-build";

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    android-nixpkgs.url = "github:tadfisher/android-nixpkgs";
  };

  nixConfig = {
    substituters = [
      "https://cache.nixos.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    ];
  };

  outputs = {
    self,
    nixpkgs,
    flake-parts,
    ...
  } @ inputs:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin"];
      perSystem = {
        pkgs,
        system,
        lib,
        ...
      }: {
        devShells.default = let
          pkgs = import nixpkgs {
            inherit system;
            config = {
              allowUnfree = true;
              android_sdk.accept_license = true;
            };
            overlays = [
              (final: prev: {
                flutter = (import inputs.nixpkgs-flutter-patched { inherit system; }).flutter;
              })
            ];
          };
          android-nixpkgs = pkgs.callPackage inputs.android-nixpkgs {};
          androidSdk = android-nixpkgs.sdk (sdkPkgs:
            with sdkPkgs; [
              cmdline-tools-latest
              build-tools-34-0-0
              build-tools-30-0-3
              platform-tools
              platforms-android-36
              platforms-android-35
              platforms-android-34
              platforms-android-33
              platforms-android-31
              ndk-27-0-12077973
              cmake-3-22-1
            ]);
          PWD = builtins.getEnv "PWD";
        in
          pkgs.mkShell {
            CHROME_EXECUTABLE = lib.getExe pkgs.chromium;
            ANDROID_SDK_ROOT = "${androidSdk}/libexec/android-sdk";
            ANDROID_NDK_ROOT = "${androidSdk}/libexec/android-sdk/ndk-bundle";
            ANDROID_AVD_HOME = "${PWD}/.android/avd";
            ANDROID_HOME = "${androidSdk}/libexec/android-sdk";
            FLUTTER_SDK = "${pkgs.flutter}";
            GRADLE_OPTS = "-Dorg.gradle.project.android.aapt2FromMavenOverride=${androidSdk}/share/android-sdk/build-tools/34.0.0/aapt2";
            LD_LIBRARY_PATH = "${PWD}/apps/onyx/build/linux/x64/debug/bundle/lib/:${PWD}/apps/onyx/build/linux/x64/release/bundle/lib/:${PWD}/apps/onyx/build/linux/x64/profile/bundle/lib/";
            buildInputs = with pkgs; [
              flutter_rust_bridge_codegen
              chromium
              flutter
              melos
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
              xorg.libXdmcp
              libxkbcommon
              xorg.libXtst
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
        formatter = pkgs.alejandra;
      };
    };
}
