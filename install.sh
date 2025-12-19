#!/bin/bash

# dotfiles installer

DOTFILES="$(cd "$(dirname "$0")" && pwd)"
BACKUP="$HOME/.dotfiles-backup"

# packages
pkgs=(
    i3-wm i3lock polybar rofi dunst picom feh xorg xorg-xinit
    alacritty starship bash-completion
    thunar gvfs btop htop fastfetch lazygit mpv
    ttf-jetbrains-mono-nerd ttf-font-awesome papirus-icon-theme
    pipewire pipewire-pulse pavucontrol
    maim xclip playerctl brightnessctl
)

aur_pkgs=(cava pywal devilspie2)

# config folders to link
configs=(
    alacritty btop cava devilspie2 dunst fastfetch gtk-3.0 gtk-4.0
    htop i3 lazygit mpv picom polybar rofi Thunar thunar wal
)

# home dotfiles to link
home_dots=(.bashrc .bash_profile .bash_logout .xinitrc .Xresources .fehbg)

install_pkgs() {
    echo ":: installing packages"
    sudo pacman -Syu --needed "${pkgs[@]}"
    
    # install yay if missing
    if ! command -v yay &>/dev/null; then
        git clone https://aur.archlinux.org/yay.git /tmp/yay
        (cd /tmp/yay && makepkg -si --noconfirm)
    fi
    
    yay -S --needed "${aur_pkgs[@]}"
}

link_configs() {
    echo ":: linking configs"
    mkdir -p "$BACKUP" ~/.config
    
    for cfg in "${configs[@]}"; do
        [[ -d "$DOTFILES/$cfg" ]] || continue
        [[ -e ~/.config/$cfg ]] && mv ~/.config/$cfg "$BACKUP/"
        ln -sf "$DOTFILES/$cfg" ~/.config/$cfg
        echo "  $cfg"
    done
    
    # starship + mimeapps
    ln -sf "$DOTFILES/starship.toml" ~/.config/starship.toml
    ln -sf "$DOTFILES/mimeapps.list" ~/.config/mimeapps.list
    
    # home dotfiles
    for dot in "${home_dots[@]}"; do
        [[ -f "$DOTFILES/$dot" ]] || continue
        [[ -e ~/$dot ]] && mv ~/$dot "$BACKUP/"
        ln -sf "$DOTFILES/$dot" ~/$dot
        echo "  $dot"
    done
    
    # extras
    ln -sf "$DOTFILES/wallpapers" ~/wallpapers
    ln -sf "$DOTFILES/scripts" ~/.local/bin/scripts
    chmod +x "$DOTFILES/scripts"/* 2>/dev/null
}

case "${1:-full}" in
    full) install_pkgs; link_configs ;;
    pkgs) install_pkgs ;;
    dots) link_configs ;;
    *)    echo "usage: ./install.sh [full|pkgs|dots]" ;;
esac

echo ":: done - restart i3 or relog"