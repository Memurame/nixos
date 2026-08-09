{
  description = "Manfred's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NIXOS/nixpkgs/nixos-unstable";
    claude-desktop.url = "github:heytcass/claude-for-linux";
  };

  outputs = { self, nixpkgs, claude-desktop, ... }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        ./hardware-configuration.nix
        {
          environment.systemPackages = [
            claude-desktop.packages.x86_64-linux.default
          ];
        }
      ];
    };
  };
}
