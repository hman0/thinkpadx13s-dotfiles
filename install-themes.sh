#!/bin/sh

# ensure curl, tar and unzip are installed
REQUIRED_CMDS="curl tar unzip"
for cmd in $REQUIRED_CMDS; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
        echo "Error: '$cmd' is not installed."
        exit 1
    fi
done

mkdir -p ~/.icons ~/.themes ~/.fonts

echo ""
echo "Starting theme installation..."
echo "Ensuring directories: ~/.icons ~/.themes ~/.fonts"
echo ""

# downloading cursor theme
echo "Downloading Bibata Modern Ice cursor theme..."
curl -L https://github.com/ful1e5/Bibata_Cursor/releases/download/v2.0.7/Bibata-Modern-Ice.tar.xz \
  | tar -xJ -C ~/.icons
echo "Cursor theme extracted to ~/.icons"
echo ""

# downloading icon theme
echo "Downloading WhiteSur Purple icon theme..."
curl -L https://files.catbox.moe/2cxvez.xz \
  | tar -xJ -C ~/.icons
echo "Icon theme extracted to ~/.icons"
echo ""

# downloading font themes
echo "Downloading JetBrainsMono Nerd Font..."
curl -Lo /tmp/JetBrainsMono.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/JetBrainsMono.zip
unzip /tmp/JetBrainsMono.zip -d ~/.fonts/JetBrainsMonoNerdFont
echo "Font theme extracted to ~/.fonts"
echo ""

# downloading gtk themes
echo "Downloading Catppuccin Mocha GTK theme"
curl -Lo /tmp/CatppuccinMochaGTK.zip https://github.com/catppuccin/gtk/releases/download/v1.0.3/catppuccin-mocha-pink-standard+default.zip
unzip /tmp/CatppuccinMochaGTK.zip -d ~/.themes/
echo "GTK theme extracted to ~/.themes"
echo ""
echo "Installation complete c:"

