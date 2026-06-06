{
  networking.firewall.allowedTCPPorts = [ 80 443 ];
  services.nginx.enable = true;
  services.nginx.virtualHosts."jellyfin.fredinand.xyz" = {
    useACMEHost = "jellyfin.fredinand.xyz";
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
      proxyPass = "http://localhost:8096";
      extraConfig = ''
        auth_request /_internal/auth;
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
  security.acme.acceptTerms = true;
  security.acme.certs."jellyfin.fredinand.xyz" = {
    webroot = "/var/lib/acme/acme-challenge";
    email = "admin@fredinand.xyz";
    group = "nginx";
  };
}
