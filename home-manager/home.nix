# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  lib,
  config,
  pkgs,
  imports,
  ...
}:
{
  # You can import other home-manager modules here
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
    ./nixvim
    inputs.noctalia.homeModules.default
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # If you want to use overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  home = {
    username = "ryanh";
    homeDirectory = "/home/ryanh";
    sessionVariables = {
      TERM = "kitty";
      SHELL = "fish";
    };
  };

  # Add stuff for your user as you see fit:
  home.packages = [
    pkgs.firefox
    pkgs.htop
    pkgs.kitty
    pkgs.zoxide
    pkgs.fish
    pkgs.eza
    pkgs.fastfetch
    pkgs.lazygit
    pkgs.nixd
    pkgs.nixfmt
    pkgs.stylua
    pkgs.shfmt
  ];

  # programs settings
  programs.home-manager.enable = true;

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };
  programs.git = {
    enable = true;
    settings = {
      user.email = "ryanhungryan@gmail.com";
      user.name = "Ryan Hung";

      init.defaultBranch = "main";
    };
  };
  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = true;
  };
  programs.lazygit.enable = true;

  programs.kitty = {
    enable = true;
    settings = {
      shell = "fish";
    };
    shellIntegration.enableFishIntegration = true;
  };

  programs.fish = {
    enable = true;

    shellAliases = {
      l = "eza -l";
      "c" = "clear";
      "lg" = "lazygit";
      "hs" = "home-manager switch --flake .#ryanh@nixos";
      "ns" = "sudo nixos-rebuild switch --flake .#nixos";
    };
  };

  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;

    config = rec {
      modifier = "Mod4";
      terminal = "kitty";
      defaultWorkspace = "1";
      startup = [
        { command = "noctalia"; }
      ];
      keybindings = lib.mkOptionDefault {
        "${modifier}+d" = "exec noctalia msg panel-toggle launcher";
        "${modifier}+s" = "exec noctalia msg panel-toggle control-center";
        "${modifier}+comma" = "exec noctalia msg settings-toggle";
      };
    };
  };

  programs.noctalia = {
    enable = true;
    settings = {
      theme = {
        mode = "dark";
        source = "builtin";
        builtin = "Nord";
      };

      wallpaper = {
        enable = true;
        default.path = "/home/ryanh/Pictures/wallpaper/nixos.png";
      };
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "25.11";
}
