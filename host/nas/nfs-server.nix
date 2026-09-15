{
  services.nfs.server.enable = true;
  services.nfs.server.exports = ''
    /tank    192.168.178.0/24(insecure,rw,sync,no_subtree_check)
  '';
  # nfsv3 requires different ports !
  # https://wiki.nixos.org/wiki/NFS#Firewall
  networking.firewall.allowedTCPPorts = [ 2049 ];
}
