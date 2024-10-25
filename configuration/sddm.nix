{ pkgs, ... }:
{
  services.displayManager.sddm = {
    enable = true;
    theme = "Elegant";
    settings.Theme.ThemeDir = "${pkgs.elegant-sddm.override {
       themeConfig.General = {
         background = "${builtins.fetchurl {
           url = "https://raw.githubusercontent.com/JaKooLit/Wallpaper-Bank/a0f287a72a04eac7acdaabcaf1a9ecfbdcea1eb8/wallpapers/Anime-City-Night.png";
           sha256 = "sha256:1yv1ckg95614mcldkwznvbxdylrjfmsahdf6c9fp2zk339vs34z1";
         }}";
       };
    }}/share/sddm/themes";
    wayland = {
      enable = true;
      compositor = "kwin";
    };
  };
}
