# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
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
    sessionVariables = 	{
	TERM = "kitty";
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
	pkgs.gh 
	pkgs.nixd
	];


	# programs settings
  programs.home-manager.enable = true;


  programs.nixvim = {
  	enable = true;
	defaultEditor = true;
	clipboard = {register = "unnamedplus";};
	globals = {
		mapleader = " ";
		};
	opts = {
		relativenumber = true;
		tabstop = 4;
		};
		colorschemes.nord.enable = true;
		lsp = {
			inlayHints.enable = true;
			servers = {
				lua_ls.enable = true;
				nixd.enable = true;
				};
				};
		plugins = {
				cmp = {
						enable = true;
						autoEnableSources = true;
						settings.sources = [ 
								{ name = "nvim_lsp"; }
								];
						};
				treesitter = {
						enable = true;
						highlight.enable = true;
						grammarPackages = with config.programs.nixvim.plugins.treesitter.package.builtGrammars; [
								bash
								nix
								fish
								lua
								python
						];
				};
				};
  };
  programs.zoxide = { enable = true; enableFishIntegration = true;};
  programs.git = {
  	enable = true;
	settings = {
		user.email = "ryanhungryan@gmail.com";
		user.name = "Ryan Hung";
		
		init.defaultBranch = "main";
		};
		};
  programs.lazygit.enable = true;

  programs.kitty = {
  	enable = true;
	shellIntegration.enableFishIntegration = true;
	};

  programs.fish = {
  	enable = true;

	shellAliases = { l = "eza -l"; "c" = "clear";};
	};


wayland.windowManager.sway = {
	enable = true;
	wrapperFeatures.gtk = true;

	config = rec {
		modifier = "Mod4";
		terminal = "kitty";
		};
		};

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "25.11";
}
