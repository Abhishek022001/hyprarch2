<div align="center">
    
<img src="https://user-images.githubusercontent.com/25181517/186884156-e63da389-f3e1-4dca-a6c1-d76e886ba22a.png" width="200" height="200"/>
</div>

<div align="center">
    
<img src="https://readme-typing-svg.demolab.com?font=Iosevka+Nerd+Font&weight=900&pause=1000&color=6791C9&background=0C0E0F00&center=true&vCenter=true&width=435&lines=Welcome to hyprarch2 !"/>
</div>

<div align="center">

[![Release](https://img.shields.io/badge/Latest_Release-v0.2.5-blue.svg)](https://github.com/g5ostXa/hyprarch2/releases/tag/v0.2.5)
</div>

## 📦 Sources
- [arch-wiki](https://wiki.archlinux.org)
- [dotfiles (ml4w)](https://github.com/mylinuxforwork/dotfiles)
- [hyprland wiki](https://wiki.hyprland.org)
- [wallpaper](https://github.com/g5ostXa/wallpaper)

## ⚙️ Setup and installation
> [!IMPORTANT]
> - The installation process is devided in 2 main steps, both of which are essential. The first step is the installation of arch-base and the second step is the installation of hyprarch2 on top of arch.
> - If installing in virt-manager, please verify that **_3D acceleration_** is enabled in **_Video Virtio_** and the **_Listen type_** is set to **_None_** in **_Display Spice_**
> - To install arch manually, refer to the  [arch-lvm-luks.md](https://github.com/g5ostXa/hyprarch2/blob/master/docs/archbase/arch-lvm-luks.md) guide. Alternatively, you can simply run [archinstall](https://github.com/archlinux/archinstall) to install arch automatically (The easy way). 
> - Before installing hyprarch2, please make sure that all needed dependencies are installed
```
$ sudo pacman -S --needed --noconfirm wireless_tools dialog os-prober mtools dosfstools base-devel git reflector xdg-utils xdg-user-dirs gum dnsmasq htop fastfetch
```
- Then, Download the [Repo](https://github.com/g5ostXa/hyprarch2) in the `~/Downloads` directory and run the [install script](https://github.com/g5ostXa/hyprarch2/blob/master/install.sh)
```
$ cd Downloads
$ git clone --depth 1 git@github.com:g5ostXa/hyprarch2.git
$ cd hyprarch2 && ./install.sh
```

## ➜ Hyprland 
- Start [Hyprland](https://hyprland.org) from tty
```
$ Hyprland
```

## ⌨️ Some useful keybinds
- `SUPER` + `B` : Firefox
- `SUPER` + `RETURN` : Alacritty
- `SUPER` + `CTRL` + `RETURN` : Rofi 
- `SUPER` + `SHIFT` + `B` : Reload waybar 
- `SUPER` + `CTRL` + `Q` : Wlogout
- `SUPER` + `Q` : Killactive
- `SUPER` + `CTRL` + `P` : Proton-pass
- `SUPER` + `E` : Thunar
- `SUPER` + `F` : Fullscreen
- `SUPER` + `T` : Togglefloating
