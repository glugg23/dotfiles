{
  disko,
  git,
  gum,
  wget,
  writeShellApplication,
}:

writeShellApplication {
  name = "nixos-installer";
  runtimeInputs = [
    disko
    git
    gum
    wget
  ];
  text = ''
    if [ "$(id -u)" -eq 0 ]; then
      echo "[ERROR] $(basename "$0") should not be run as root"
      exit 1
    fi

    if [ ! -d "$HOME/dotfiles/.git" ]; then
      git clone https://github.com/glugg23/dotfiles.git "$HOME/dotfiles"
    fi

    TARGET_HOST=$(
      find "$HOME/dotfiles/modules/hosts" \
        -mindepth 2 -maxdepth 2 \
        -type f -name configuration.nix \
        -printf '%h\n' |
      sed 's|.*/||' |
      grep -vx iso |
      gum choose
    )

    if [ ! -e "$HOME/dotfiles/modules/hosts/$TARGET_HOST/disko.nix" ]; then
      echo "[ERROR] $(basename "$0") was unable to find the disko config at $HOME/dotfiles/modules/hosts/$TARGET_HOST/disko.nix"
      exit 1
    fi

    gum confirm --default=false \
      "[WARNING] This will ERASE ALL DATA on disk for $TARGET_HOST. Do you wish to continue?"

    echo "Creating disk partitions"
    sudo disko \
      --mode destroy,format,mount \
      "$HOME/dotfiles/modules/hosts/$TARGET_HOST/disko.nix"

    sudo nixos-install --flake "$HOME/dotfiles#$TARGET_HOST"

    echo "Copying dotfiles to home"
    cp -r "$HOME/dotfiles" /mnt/home/max/

    GRAPHICS_ENABLED=$(nix eval "$HOME/dotfiles#nixosConfigurations.$TARGET_HOST.config.hardware.graphics.enable")

    if [ "$GRAPHICS_ENABLED" = "true" ]; then
      echo "Downloading wallpapers"
      WALLPAPERS=/mnt/home/max/Pictures/Wallpapers
      mkdir -p $WALLPAPERS
      wget -qP $WALLPAPERS -- https://github.com/glugg23/dotfiles/releases/download/wallpapers/garden_of_words_1080.jpg
      wget -qP $WALLPAPERS -- https://github.com/glugg23/dotfiles/releases/download/wallpapers/garden_of_words_4k.jpg
    fi

    echo "Setting password for account"
    sudo nixos-enter --root /mnt -c 'chown -R max:users /home/max && passwd max'
  '';
}
