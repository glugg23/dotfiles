{ pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    font.name = "JetBrains Mono";
    font.size = 12;
    shellIntegration.enableZshIntegration = true;
    themeFile = "everforest_dark_hard";
    keybindings = {
      "control+c" = "copy_or_interrupt";
      "control+v" = "paste_from_clipboard";
    };
    settings = {
      "paste_actions" = "quote-urls-at-prompt,no-op";
      "enable_audio_bell" = false;
      "window_padding_width" = 6;
    };
  };
}
