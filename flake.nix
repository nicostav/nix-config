# ============================================================
# flake.nix
# Root flake — pins nixpkgs + home-manager and declares all
# NixOS host configurations.
# ============================================================

{
  description = "NixOS system configurations";

  # ── Inputs ──────────────────────────────────────────────────
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";   # use the same nixpkgs, no duplicates
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    zen-browser = {
        url = "github:0xc000022070/zen-browser-flake";
        inputs.nixpkgs.follows = "nixpkgs";
        inputs.home-manager.follows = "home-manager";
    };
  };

  # ── Outputs ─────────────────────────────────────────────────
  outputs = { self, nixpkgs, home-manager, plasma-manager, zen-browser, ... }@inputs:
  let
    system = "x86_64-linux";   # change to "aarch64-linux" if on ARM
  in
  {
    nixosConfigurations = {

      # ── Desktop ─────────────────────────────────────────────
      nixos-desktop = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs zen-browser; };
        modules = [
          ./hosts/desktop/configuration.nix

          # Wire home-manager in as a NixOS module (replaces the
          # channel-based <home-manager/nixos> import)
          home-manager.nixosModules.home-manager
            { home-manager.extraSpecialArgs = { inherit inputs; }; }
          ./home/default-secret.nix
        ];
      };

      # ── Notebook ────────────────────────────────────────────
      nixos-notebook = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/notebook/configuration.nix

          home-manager.nixosModules.home-manager
          ./home/default.nix
        ];
      };

    };
  };
}
