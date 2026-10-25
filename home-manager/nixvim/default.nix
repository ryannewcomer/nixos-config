{ inputs, ... }:
{
  imports = [
    ./plugins.nix
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    clipboard = {
      register = "unnamedplus";
    };
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
        nixd = {
          enable = true;
          settings = {
            formatting.command = [ "nixfmt" ];
          };
        };
      };
    };
    keymaps = [
      {
        action = "<cmd>NvimTreeFocus<CR>";
        key = "<leader>e";
      }
    ];
  };
}
