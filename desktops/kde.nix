# desktops/kde.nix
{
  services.xserver.enable = true;

  services.displayManager.sddm.settings = {
    General = {
      Numlock = "on";
    };
  };

  services.desktopManager.plasma6.enable = true;

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
}
