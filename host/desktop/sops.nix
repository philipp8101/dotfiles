{
  sops.defaultSopsFile = ./secrets/secrets.yaml;
  sops.secrets.wg-key.sopsFile = ./secrets/wg.key;
}
