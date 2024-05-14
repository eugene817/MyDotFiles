{ config, pkgs, ... }:

{

  home.username = "yasakar";
  home.homeDirectory = "/home/yasakar";


   home.packages = with pkgs; [
        curl
        git
        zsh
  ];


  programs.zsh = {
  	enable = true;
	enableCompletion = true;
	autosuggestion.enable = true;
	syntaxHighlighting.enable = true;

	shellAliases = {
	  l = "ls -la";
	  rebuild = "sudo nixos-rebuild switch";
          conf = "sudo -E nvim /etc/nixos/configuration.nix";
	};


    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "robbyrussell";     };
  };
 	
   home.file = {

  };
  home.sessionVariables = {
    EDITOR = "nvim";
  };

    home.activation = let
      sudoNvim = ''
        alias snvim="sudo -E nvim"
      '';
    in {
      text = "${sudoNvim}";
    };

  home.stateVersion = "23.11";
  programs.home-manager.enable = true;
}
