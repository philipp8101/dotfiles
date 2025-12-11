{
  programs.git = {
    enable = true;
    settings = {
      user.email = "philipp8101@gmail.com";
      user.name = "Philipp Conrad";
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
      core.editor = "nvim";
      push.autoSetupRemote = "true";
      merge.conflictstyle = "diff3";
    };
    lfs.enable = true;
  };
  programs.delta.enableGitIntegration = true;
}
