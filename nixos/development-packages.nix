{ config, pkgs, ... }:

{
  # Allow unfree packages for development tools
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.android_sdk.accept_license = true;

  environment.systemPackages = with pkgs; [
    # Node.js ecosystem (includes npm and npx)
    nodejs_22
    nodePackages.npm
    nodePackages.pnpm
    nodePackages.yarn

    python314
    python314Packages.numpy
    python314Packages.scipy


    goreleaser

    # Android Development
    android-tools      # Platform tools for Android development
    gradle_9
    javaPackages.compiler.openjdk17
    androidenv.androidPkgs.emulator
    androidenv.androidPkgs.androidsdk
    # androidenv.androidPkgs.all.system-images.v34.default.x86_64
    # androidenv.androidPkgs.all.system-images.v34.default.arm64-v8a
    scrcpy             # Display and control Android devices
    adbfs-rootless     # Mount Android devices via adb as file systems
    kotlin
    kotlin-native
    kotlin-language-server
    # More Android-related packages you might consider:
    # apktool         # Tool for reverse engineering Android APK files
    # jadx            # Dex to Java decompiler

    # Clouds
    azure-cli
    azure-cli-extensions.ad
    awscli2
    flyctl
    yandex-cloud

  ];

  virtualisation.docker.enable = true;
}

