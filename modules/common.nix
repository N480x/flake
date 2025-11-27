{ config, pkgs, ... }:
{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  time.timeZone = "Europe/Berlin";

  networking.networkmanager.enable = true;
 
  services.openssh.enable = true;

  environment.systemPackages = with pkgs; [
    vim git htop
  ];

  system.stateVersion = "25.05";
}
