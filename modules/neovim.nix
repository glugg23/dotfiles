{
  config,
  pkgs,
  lib,
  ...
}:

let
  tree-sitter-nix = pkgs.tree-sitter.builtGrammars."tree-sitter-nix".overrideAttrs {
    version = "0.5.0";
    src = pkgs.fetchFromGitHub {
      owner = "numtide";
      repo = "tree-sitter-nix";
      rev = "v0.5.0";
      hash = "sha256-oeFnUuaq+OtpzGG/HLYY6eRpvP35LhMWnltAfRoyBug=";
    };
  };

  treeSitterGrammars = [
    pkgs.tree-sitter.builtGrammars."tree-sitter-elixir"
    tree-sitter-nix
  ];

  treeSitterParsers = pkgs.tree-sitter.withPlugins (_: treeSitterGrammars);

  treeSitterQueries = pkgs.runCommandLocal "nvim-treesitter-queries" { } ''
    mkdir -p "$out"

    ${lib.concatMapStringsSep "\n" (
      grammar:
      let
        lang = lib.replaceStrings [ "-" ] [ "_" ] (lib.removePrefix "tree-sitter-" (lib.getName grammar));
      in
      ''
        if [ -d "${grammar}/queries" ]; then
          ln -s "${grammar}/queries" "$out/${lang}"
        fi
      ''
    ) treeSitterGrammars}
  '';
in
{
  programs.neovim = {
    enable = true;
    sideloadInitLua = true;
    withRuby = false;
    withPython3 = false;
  };

  home.packages = with pkgs; [
    fd
    ripgrep
  ];

  xdg.configFile."nvim" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/nvim";
    recursive = true;
  };

  xdg.dataFile."nvim/site/parser".source = treeSitterParsers;
  xdg.dataFile."nvim/site/queries".source = treeSitterQueries;
}
