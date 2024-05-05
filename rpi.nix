{config, lib, pkgs, ...}:{
    disabledModules = [
        "profiles/base.nix"
    ];

    system.stateVersion = "23.11";
    users.users = {
        pi = {
            password = "admin123";
            isNormalUser = true;
            extraGroups = [ "wheel" ];
            openssh.authorizedKeys.keys = [
                "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDDUD7/RYfYekYxqGBTA/TFID8ysuO7yS6eJF5jo5yCgxAvKLSnL678gLZ4TyA6yR1305mKSV+40QhS9+dS2Y89qXfJUDdujUXwQnY5GqP9IauRH/fjOkcFet4xOi0J2QHIA9Oj0oNBFGJEKakTvppIS6fEan7dBD8rKyLME4XpYk6CM3Rjg9whhib4q5rIyB+6mnW4Jgs+hfgzen+AvunBqdINZo1pNmMYo/CydzTClQoOxjCj3yIiL7jaqdMX0eXH5X5dO+cFoe4Cl+iZ/mI/T1KFCzRE0hzn99iBe5nXqzrFeI1XXPJ1Sp+B6sWK9H0WBq3VW1V8LoUiWT3CrNpgyQnvVBIL1reQbe5HoiEkgUl4cJMmzNgeFDDHhiQZPZiXGtiOOgp96P4xtTtEgN45t2lN0lCJ0Ss2V4tvWXzBJx+yGHY+/ZflG0iMSrmphmdL1ONLdMx+UYabCYzBXky958mDHeP6mqDWjMMTMIHWuB5NEmA+QPBWMF9VmwPzz/8= philipp"
            ];
        };
    };
    networking.firewall.enable = false;

    nixpkgs.config.allowUnfree = true;
    environment.systemPackages = with pkgs; [
        openssh
    ];

    services.openssh.enable = true;
}
