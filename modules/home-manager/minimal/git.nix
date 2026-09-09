{
  programs.git = {
    enable = true;
    settings = {
      credential.helper = "store"; 
      core.askpass = ""; 
      init = {
        defaultBranch = "main";
      };
      user = {
        email = "recluse0code@gmail.com";
        name = "recluse0";
      };
    };
  };
}

