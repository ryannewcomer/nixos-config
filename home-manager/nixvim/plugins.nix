{
  config,
  lib,
  pkgs,
  ...
}:
{
  programs.nixvim.plugins = {

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
    conform-nvim = {
      enable = true;
      settings = {

        formatters_by_ft = {
          nix = [ "nixfmt" ];
          lua = [ "stylua" ];
          bach = [ "shfmt" ];
        };
        format_on_save = {
          timeout_ms = 500;
          lsp_format = "fallback";
        };
        formatters = {
          shellcheck = {
            command = lib.getExe pkgs.shellcheck;
          };
        };
      };
    };
    nvim-tree = {
      enable = true;
    };
  };
}
