{ config, ... }:
{
  services.nginx.virtualHosts."immich.fredinand.xyz" = {
    useACMEHost = "immich.fredinand.xyz";
    addSSL = true;
    listen = [ {
      addr = "0.0.0.0";
      port = 443;
      ssl = true;
      proxyProtocol = true;
    } ];
    extraConfig = ''
      set_real_ip_from 10.0.1.7; 
      real_ip_header proxy_protocol;
    '';
    locations."/" = {
      proxyPass = "http://localhost:${toString config.services.immich.port}";
      extraConfig = ''
      auth_request /_internal/auth;
      client_max_body_size 1G;
      proxy_set_header Upgrade $http_upgrade;
      proxy_set_header Connection $connection_upgrade;
      '';
    };
    locations."/_internal/auth" = {
      extraConfig = ''
      internal;
      proxy_set_header X-Original-HOST $host;
      proxy_set_header X-Original-IP $remote_addr;
      proxy_set_header Content-Length    "";
      proxy_pass_request_body            off;
      proxy_pass_request_headers      on;
      '';
      proxyPass = "https://auth.fredinand.xyz";
    };
  };
  security.acme.certs."immich.fredinand.xyz" = {
    webroot = "/var/lib/acme/acme-challenge";
    email = "admin@fredinand.xyz";
    group = "nginx";
  };
  services.immich = {
    enable = true;
    settings.server.externalDomain = "https://immich.fredinand.xyz";
    mediaLocation = "/tank/immich";
  };
}
