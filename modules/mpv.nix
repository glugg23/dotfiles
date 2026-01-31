{ pkgs, ... }:

{
  programs.mpv = {
    enable = true;
    bindings = {
      l = "seek 10";
      j = "seek -10";
      k = "cycle pause";
      MBTN_Mid = "cycle pause";
    };
    config = {
      osd-bar = false;
      hwdec = "auto";
      geometry = "75%x75%";
      keep-open = true;
    };
    /*
    # From desktop settings but not needed on laptop
    scriptOpts = {
      osc = {
        scalewindowed = 1.25;
        scalefullscreen = 1.25;
      };
    };
    */
    scripts = [ pkgs.mpvScripts.mpris ];
  };
}
