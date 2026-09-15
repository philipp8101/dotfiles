{
  services.nginx.virtualHosts."_" = {
    listen = [ {
      addr = "0.0.0.0";
      port = 80;
      extraParameters = [ "default_server" ];
    } ];
    locations."/.well-known/acme-challenge".root = "/var/lib/acme/acme-challenge";
  };
}
