{ ... }: {
  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = true; # git push/pull on private repos "just works"
    settings = {
      git_protocol = "https";
      editor = "nvim"; # matches your logpush script's $EDITOR
    };
  };
}
