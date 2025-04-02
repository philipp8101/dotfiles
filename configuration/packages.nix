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
    rar
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
    discord
    tidal-hifi
    libsForQt5.qtstyleplugin-kvantum
    libsForQt5.qt5ct
    kdePackages.qt6ct
    kdePackages.qtstyleplugin-kvantum
    self.outputs.packages.${system}.nixvim
    adwaita-icon-theme
    kdePackages.dolphin
    kdePackages.kde-cli-tools
    kdePackages.breeze
    kdePackages.breeze-icons
    kdePackages.qtwayland
    kdePackages.qtsvg
    kdePackages.kio-fuse
    kdePackages.kio-extras
    kdePackages.kdesdk-thumbnailers
    kdePackages.kdegraphics-thumbnailers
    kdePackages.ffmpegthumbs
    kdePackages.dolphin-plugins
    kdePackages.okular
    kdePackages.gwenview
    kdePackages.ark
    libsForQt5.kservice
    libsForQt5.qt5.qtgraphicaleffects
    thunderbird
    bottles
    man-pages
    nix-output-monitor
    lsof
    # https://github.com/aristocratos/btop/issues/426#issuecomment-2104289634
    (btop.override {cudaSupport = true;})
  ];
}
