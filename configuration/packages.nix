{ pkgs, self, ... }:
{
  environment.systemPackages = with pkgs; [
    wget
    traceroute
    dig
    file
    killall
    whois
    nix-tree
    jq
    smartmontools
    tmux
    kitty
    polkit
    dconf
    xwayland
    gcc
    unzip
    fzf
    home-manager
    ripgrep
    firefox
    xsel
    lutris
    nix-index
    htop-vim
    obsidian
    wl-clipboard
    vesktop
    tidal-hifi
    libsForQt5.qtstyleplugin-kvantum
    libsForQt5.qt5ct
    self.outputs.packages.${system}.nixvim
    adwaita-icon-theme
    libsForQt5.dolphin
    libsForQt5.kde-cli-tools
    kdePackages.breeze
    libsForQt5.breeze-icons
    libsForQt5.qtwayland
    libsForQt5.qtsvg
    kdePackages.kio-fuse
    libsForQt5.kio-extras
    kdePackages.kdesdk-thumbnailers
    libsForQt5.kdegraphics-thumbnailers
    libsForQt5.ffmpegthumbs
    libsForQt5.dolphin-plugins
    okular
    gwenview
    ark
    libsForQt5.qt5.qtgraphicaleffects
    thunderbird
    bottles
  ];
}
