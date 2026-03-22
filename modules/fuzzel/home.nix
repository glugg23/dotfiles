{ ... }:

{
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        terminal = "kitty";
        font = "JetBrains Mono NF:size=14";
      };
      colors =
        let
          fg = "d3c6aaff";
          ylw = "dbbc7fff";
          grn = "a7c080ff";
        in
        {
          background = "272e33ff";
          text = fg;
          prompt = fg;
          input = fg;
          match = ylw;
          selection = "3c4841ff";
          selection-text = grn;
          selection-match = ylw;
          border = grn;
        };
      border = {
        width = 2;
        radius = 4;
        selection-radius = 4;
      };
    };
  };
}
