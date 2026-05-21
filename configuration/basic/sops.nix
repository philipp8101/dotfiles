{ inputs, user, ... }:
{
  imports = [ inputs.sops-nix.nixosModules.sops ];
  sops.defaultSopsFormat = "yaml";
  sops.age.keyFile = "/home/${user}/.config/sops/age/keys.txt";
}
