{
  writeShellApplication,
  awww,
  homeDirectory,
}:

writeShellApplication {
  name = "awww-background.sh";
  runtimeInputs = [ awww ];
  text = ''
    awww-daemon &
    awww-daemon -n overlay &
    awww img '${homeDirectory}/Pictures/Wallpapers/garden_of_words_laptop.jpg' --transition-type none
    awww img -n overlay '${homeDirectory}/Pictures/Wallpapers/garden_of_words_laptop_blur.jpg' --transition-type none
  '';
}
