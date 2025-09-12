{
  programs.git = {
    enable = true;
    userEmail = "recluse0code@gmail.com";
    userName = "recluse0";
    extraConfig = {
      credential.helper = "store"; 
      core.askpass = ""; # Any other git config settings
    };
  };
}

