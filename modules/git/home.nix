{
  programs.git = {
    enable = true;
    settings = {
      init.defaultBranch = "main";
      user = {
        email = "git@leonhardt.dev";
        name = "Max Leonhardt";
      };
    };
  };
}
