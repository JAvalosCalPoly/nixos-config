{ config, pkgs, inputs, ... }:

{
  imports = [ inputs.areofyl-fetch.homeManagerModules.default ];

  programs.fetch = {
    enable = true;
    labelColor = "red";
    info = [
      "os"
      "kernel"
      "uptime"
      "packages"
      "shell"
      "wm"
      "cpu"
      "gpu"
      "memory"
      "swap"
      "disk"
    ];
    speed = 1.0;
    spin = "xy";
  };

programs.fish = {
  enable = true;

  shellAliases = {
    rebuild = "sudo nixos-rebuild switch --flake /etc/nixos#default";
  };

  functions = {
    extract = ''
      if test (count $argv) -eq 0
        echo "Usage: extract <archive>"
        return 1
      end

      set file $argv[1]

      if not test -f "$file"
        echo "'$file' is not a valid file"
        return 1
      end

      switch "$file"
        case "*.tar.gz" "*.tgz"
          tar xzf "$file"
        case "*.tar.bz2" "*.tbz2"
          tar xjf "$file"
        case "*.tar.xz" "*.txz"
          tar xJf "$file"
        case "*.tar.zst" "*.tzst"
          tar --zstd -xf "$file"
        case "*.tar"
          tar xf "$file"
        case "*.zip"
          unzip "$file"
        case "*.7z"
          7z x "$file"
        case "*.rar"
          unrar x "$file"
        case "*.gz"
          gunzip "$file"
        case "*.bz2"
          bunzip2 "$file"
        case "*.xz"
          unxz "$file"
        case "*.zst"
          unzstd "$file"
        case "*"
          echo "Don't know how to extract '$file'"
          return 1
      end
    '';
  };
};

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "otter";
  home.homeDirectory = "/home/otter";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "26.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    firefox
    alacritty
    vlc
    imv
    protonup-ng
    easyeffects
    discord
    nerd-fonts.sauce-code-pro
    nerd-fonts.jetbrains-mono

    (pkgs.writeShellScriptBin "my-hello" ''
      echo "Hello, ${config.home.username}!"
    '')
  ];

  # So easyeffects can run in the background
  services.easyeffects.enable = true;

  home.sessionVariables = {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS =
          "\${HOME}/.steam/root/compatibilitytools.d";
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/otter/etc/profile.d/hm-session-vars.sh
  #d

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
