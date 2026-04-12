{ pkgs, config, ... }:
{
  hardware = {
    graphics.enable = true;
    graphics.enable32Bit = true; # https://nixos.wiki/wiki/Lutris
    nvidia = {
      modesetting.enable = true;
      open = false;
      nvidiaSettings = true;
      powerManagement.enable = true;
      package = config.boot.kernelPackages.nvidiaPackages.legacy_580;
    };
  };
  environment.systemPackages = [ pkgs.nvtopPackages.nvidia ];
  # nixpkgs.config.cudaSupport = true;
  services.xserver.videoDrivers = [ "nvidia" ];
}
