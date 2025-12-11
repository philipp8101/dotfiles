{ pkgs, user, ... }:
{
  virtualisation.spiceUSBRedirection.enable = true;
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
    };
  };
  programs.virt-manager.enable = true;
  environment.systemPackages = with pkgs; [
    virtiofsd
  ];
  users.users.${user} = {
    extraGroups = [ "libvirtd" ];
  };
}
