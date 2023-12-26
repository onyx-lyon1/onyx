{
  inputs = {
    #nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs.url = "github:hatch01/nixpkgs/master";

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
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
          };
          buildToolsVersionForAapt2 = "34.0.0-rc4";
          androidComposition = pkgs.androidenv.composeAndroidPackages {
            # Installing both version for aapt2 and version that flutter wants
            buildToolsVersions = [buildToolsVersionForAapt2 "30.0.3"];
            platformVersions = ["34" "33" "31" "30"];
            abiVersions = ["armeabi-v7a" "arm64-v8a" "x86" "x86_64"];
            includeEmulator = true;
            emulatorVersion = "34.1.9";
            toolsVersion = "26.1.1";
            platformToolsVersion = "33.0.3";
            includeSources = false;
            includeSystemImages = false;
            systemImageTypes = ["google_apis_playstore"];
            # cmakeVersions = [ "3.10.2" ];
            includeNDK = true;
            # ndkVersions = [ "22.0.7026061" ];
            useGoogleAPIs = false;
            useGoogleTVAddOns = false;
            extraLicenses = [
              "android-googletv-license"
              "android-sdk-arm-dbt-license"
              "android-sdk-license"
              "android-sdk-preview-license"
              "google-gdk-license"
              "intel-android-extra-license"
              "intel-android-sysimage-license"
              "mips-android-sysimage-license"
            ];
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
            GRADLE_OPTS = "-Dorg.gradle.project.android.aapt2FromMavenOverride=${androidSdk}/libexec/android-sdk/build-tools/${buildToolsVersionForAapt2}/aapt2";
            LD_LIBRARY_PATH = "${PWD}/apps/onyx/build/linux/x64/debug/bundle/lib/:${PWD}/apps/onyx/build/linux/x64/release/bundle/lib/:${PWD}/apps/onyx/build/linux/x64/profile/bundle/lib/";
            buildInputs = with pkgs; [
              chromium
              flutter
              melos
              jdk17
              androidSdk
              at-spi2-core
              clang
              dart
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
              ];
          };
        formatter = pkgs.alejandra;
      };
    };
}
