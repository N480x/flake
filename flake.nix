{
  description = " Flaky, Multios, btrfs, ... ";

  inputs = {
    # This is pointing to an unstable release.
    # If you prefer a stable release instead, you can this to the latest number shown here: https://nixos.org/download
    # i.e. nixos-24.11
    # Use `nix flake update` to update the flake to the latest revision of the chosen release channel.
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  outputs = inputs@{ self, nixpkgs, ... }: {
    # NOTE: 'nixos' is the default hostname
    nixosConfigurations = {
      laptop = nixpkgs.lib.nixosSystem {
        modules = [ 
          ./modules/common.nix
          ./modules/common-laptop.nix
          ./modules/users/mekush.nix
          ./modules/hardware/n480x-hw.nix
          ./hosts/laptop/n480x-config.nix 
        ];
      };
      desktop = nixpkgs.lib.nixosSystem {
        modules = [ 
          ./modules/common.nix
          ./modules/common-desktop.nix
          ./modules/users/meKush.nix
          ./modules/hardware/ndex-hw.nix
          ./hosts/laptop/ndex-config.nix 
        ];
      };
      server = nixpkgs.lib.nixosSystem {
        modules = [ 
          ./modules/common.nix
          ./modules/common-server.nix
          ./modules/users/meKush.nix
          ./modules/hardware/nservx-hw.nix
          ./hosts/laptop/nservx-config.nix 
        ];
      };
    };
  };
}

