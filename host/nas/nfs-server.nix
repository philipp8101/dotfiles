{
  services.nfs.server.enable = true;
  # https://wiki.nixos.org/wiki/ZFS#NFS_share
  # using `zfs set share=on <pool>`
  services.nfs.server.exports = ''
    /tank              192.168.178.0/24(insecure,rw,sync,no_subtree_check)
    /tank/con          192.168.178.0/24(insecure,rw,sync,no_subtree_check)
    /tank/savegames    192.168.178.0/24(insecure,rw,sync,no_subtree_check)
    /tank/documents    192.168.178.0/24(insecure,rw,sync,no_subtree_check)
  '';
  # nfsv3 requires different ports !
  # https://wiki.nixos.org/wiki/NFS#Firewall
  networking.firewall.allowedTCPPorts = [ 2049 ];
}
