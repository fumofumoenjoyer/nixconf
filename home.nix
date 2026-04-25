{ config, pkgs, ... }:

{
  home.username = "fumo";
  home.homeDirectory = "/home/fumo";
  programs.git.enable = true;
  home.stateVersion = "25.11";
  programs.bash = {
    enable = true;
    shellAliases = {
      btw = "echo i use nixos, btw";
    };
  };
}
