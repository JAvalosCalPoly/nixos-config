{ pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix

    ../../common/maintenance.nix
    ../../common/nix.nix
    ../../common/packages.nix
    ../../common/programs.nix

    ../../desktops/kde.nix
    ../../desktops/kdeTheme.nix
    ../../desktops/audio.nix
    ../../desktops/printing.nix

    ../../hardware/amd/cpu.nix
    ../../hardware/nvidia/rtx.nix
  ];


  boot.loader = {
    efi.canTouchEfiVariables = true;
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      useOSProber = true;
    };
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "America/Los_Angeles";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  users.users.otter = {
    isNormalUser = true;
    description = "Otter";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users.otter = import ../../users/otter/home.nix;
  };

  system.stateVersion = "26.05";
}
