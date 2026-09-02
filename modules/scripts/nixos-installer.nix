{ writeShellApplication, git, gum, disko }:

writeShellApplication {
  name = "nixos-installer";
  runtimeInputs = [
    disko
    git
    gum
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
  '';
}
