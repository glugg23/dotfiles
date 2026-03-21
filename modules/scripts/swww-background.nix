{
  writeShellApplication,
  swww,
  homeDirectory,
}:

writeShellApplication {
  name = "swww-background.sh";
  runtimeInputs = [ swww ];
  text = ''
    swww-daemon &
    swww-daemon -n overlay &
    swww img '${homeDirectory}/Pictures/Wallpapers/garden_of_words_laptop.jpg' --transition-type none
    swww img -n overlay '${homeDirectory}/Pictures/Wallpapers/garden_of_words_laptop_blur.jpg' --transition-type none
  '';
}
