{
  # Automatic garbage collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # Keep the Nix store optimized
  nix.optimise = {
    automatic = true;
    dates = [ "weekly" ];
  };

  # Automatic system updates
  system.autoUpgrade = {
    enable = true;
    dates = "weekly";
    flake = "/etc/nixos#default";
    flags = [
      "--update-input"
      "nixpkgs"
      "--commit-lock-file"
    ];
  };
}
