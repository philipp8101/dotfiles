{
  services.syncthing = {
    enable = true;
    group = "philipp";
    user = "philipp";
    dataDir = "/tank/home";
    configDir = "/tank/home/.config/syncthing";
  };
}
