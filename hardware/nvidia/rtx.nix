# hardware/nvidia/rtx.nix
{ config, ... }:

{
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.graphics.enable = true;

  hardware.nvidia = {
    open = true;
    modesetting.enable = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.latest;
  };
}
