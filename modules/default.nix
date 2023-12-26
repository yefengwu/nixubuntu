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
        pkgs.bat
        pkgs.chezmoi
        pkgs.cifs-utils
        pkgs.clang-tools
        pkgs.delta
        pkgs.ripgrep
        pkgs.fd
        pkgs.fzf
        pkgs.fish
        pkgs.fuse3
        pkgs.zellij
        pkgs.hello
        pkgs.lazygit
        pkgs.lrzsz
        pkgs.lzop
        pkgs.lua-language-server
        pkgs.gh
        pkgs.git
        pkgs.gnumake42
        pkgs.nodejs_21
        pkgs.nodePackages_latest.bash-language-server
        pkgs.neovim
        pkgs.nettools
        pkgs.joshuto
        pkgs.docker
        pkgs.rclone
        pkgs.starship
        pkgs.stylua
        pkgs.tldr
        pkgs.zoxide
        pkgs.xsel
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
