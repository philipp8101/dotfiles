{ inputs, lib, config, ... }:
{
  options.domainName = lib.mkOption { type = lib.types.str; };
  imports = [
    "${inputs.server-config}/configuration/forgejo.nix"
    ../../configuration/graphical/docker.nix
  ];
  config = {
    services.postgresql.enable = true;
    domainName = "philipp.fredinand.xyz";
    services.forgejo.settings.server.SSH_PORT = lib.mkForce 2223;
    networking.firewall.allowedTCPPorts = [ config.services.forgejo.settings.server.SSH_PORT ];
    security.acme.certs."git.${config.domainName}" = {
      webroot = "/var/lib/acme/acme-challenge";
      email = "admin@fredinand.xyz";
      group = "nginx";
    };
    security.acme.certs."${config.domainName}" = {
      webroot = "/var/lib/acme/acme-challenge";
      email = "admin@fredinand.xyz";
      group = "nginx";
    };
  };
}
