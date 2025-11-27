{ config, pkgs, ... }:
{
  users.users.meKush = {
    isNormalUser = true;
    description = "";
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.zsh;
  };

  programs = {
    zsh.enable = true;
    firefox.enable = true;
  };
}
