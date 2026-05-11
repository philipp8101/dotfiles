{
  environment.sessionVariables = {
    SSH_AUTH_SOCK = "/run/user/1000/gcr/ssh";
  };
  services.openssh.enable = true;
  # programs.ssh.startAgent = true; # replaced by gnome-keyring
  services.gnome.gnome-keyring.enable = true;
}
