# common/packages.nix
{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    neovim
    wget
    git
    sl
    pciutils
    nil
    nixfmt
  ];
}
