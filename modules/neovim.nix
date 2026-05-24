{
  config,
  pkgs,
  lib,
  ...
}:

let
  treeSitterGrammars = [
    pkgs.tree-sitter.builtGrammars."tree-sitter-elixir"
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

  xdg.configFile."nvim" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/nvim";
    recursive = true;
  };

  xdg.dataFile."nvim/site/parser".source = treeSitterParsers;
  xdg.dataFile."nvim/site/queries".source = treeSitterQueries;
}
