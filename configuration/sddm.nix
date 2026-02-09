{ pkgs, lib, config, user, ... }:
{
  services.displayManager.sddm = {
    enable = lib.mkDefault (config.home-manager.users.${user}.gui or false);
    # theme = "Elegant";
    theme = "breeze";
    # settings.Theme.ThemeDir = "${pkgs.kdePackages.plasma-desktop}/share/sddm/themes";
    wayland = {
      enable = true;
      # compositor = "kwin";
    };
    extraPackages = with pkgs.kdePackages; [
      plasma-workspace
    ];
  };
  environment.systemPackages = with pkgs.kdePackages; [
    # (pkgs.elegant-sddm.override {
    #    themeConfig.General = {
    #      background = "${builtins.fetchurl {
    #        url = "https://raw.githubusercontent.com/JaKooLit/Wallpaper-Bank/a0f287a72a04eac7acdaabcaf1a9ecfbdcea1eb8/wallpapers/Anime-City-Night.png";
    #        sha256 = "sha256:1yv1ckg95614mcldkwznvbxdylrjfmsahdf6c9fp2zk339vs34z1";
    #      }}";
    #    };
    # })
    plasma-desktop
    breeze
  ];
}
