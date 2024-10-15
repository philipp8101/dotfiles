{
  programs.git = {
    enable = true;
    userEmail = "philipp8101@gmail.com";
    userName = "Philipp Conrad";
    aliases = {
      graph = "log --all --decorate --oneline --graph";
      nb = "!f() { git checkout -b \"$1\"; }; f";
    };
    delta = {
      enable = true;
      options = {
        line-numbers = true;
      };
    };
    lfs.enable = true;
    extraConfig = {
      core = {
        editor = "nvim";
      };
      push = {
        autoSetupRemote = "true";
      };
      merge = {
        conflictstyle = "diff3";
      };
    };
  };
}
