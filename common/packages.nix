# common/packages.nix
{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    wget
    neovim

    # diagnostics
    pciutils
    usbutils
    lshw

    # filesystem/tools
    tree
    unzip
    zip

    # nix development
    nil
    nixfmt

    # extract utilities
    unzip
    p7zip
    unrar
    zstd
  ];
}
