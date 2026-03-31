{ ... }:

{
  programs.hyprlock = {
    enable = true;
    settings =
      let
        font = "JetBrains Mono NF";
      in
      {
        auth.fingerprint.enabled = true;
        background = {
          path = "screenshot";
          blur_passes = 3;
        };
        input-field = {
          size = "20%, 5%";
          outline_thickness = 4;
          rounding = 4;
          inner_color = "rgb(272e33)";
          outer_color = "rgb(a7c080)";
          check_color = "rgb(dbbc7f)";
          fail_color = "rgb(e67e80)";
          font_color = "rgb(d3c6aa)";
          font_family = font;
          fail_text = "$PAMFAIL";
        };
        label = [
          {
            text = "$TIME12";
            font_size = 72;
            font_family = font;
            position = "0, -72";
            valign = "top";
          }
          {
            text = ''cmd[update:60000] date +"%d/%M/%Y"'';
            font_size = 24;
            font_family = font;
            position = "0, -204";
            valign = "top";
          }
        ];
      };
  };
}
