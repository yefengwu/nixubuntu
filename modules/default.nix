{ config, lib, pkgs, ... }:

{
  config = {
    nixpkgs.hostPlatform = "x86_64-linux";

    environment = {
      etc = {
        "foo.conf".text = ''
          launch_the_rockets = true
        '';
        "wsl.conf".source = ./wsl.conf; 
      };
      systemPackages = [
        pkgs.chezmoi
        pkgs.ripgrep
        pkgs.fd
        pkgs.fzf
        pkgs.fish
        pkgs.zellij
        pkgs.hello
        pkgs.lazygit
        pkgs.lua-language-server
        pkgs.gh
        pkgs.gcc6
        pkgs.neovim
        pkgs.joshuto
        pkgs.docker
        pkgs.starship
        pkgs.zoxide
      ];
    };

    systemd.services = {
      foo = {
        enable = true;
        serviceConfig = {
          Type = "oneshot";
          RemainAfterExit = true;
        };
        wantedBy = [ "system-manager.target" ];
        script = ''
          ${lib.getBin pkgs.hello}/bin/hello
          echo "We launched the rockets!"
        '';
      };
    };
  };
}
