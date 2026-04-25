{ config, pkgs, ... }:

{
  home.username = "fumo";
  home.homeDirectory = "/home/fumo";
  home.stateVersion = "25.11";
  
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "FumoFumoEnjoyer";
        email = "FumoFumoEnjoyer@fumofumo.dev";
      };
    };
  };

  programs.gh = {
    enable = true;
    gitCredentialHelper = {
      enable = true;
    };
  };   

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      theme = "dpoggi";
      plugins = [ "git" "sudo" ];
    };

  };
}
