{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    zig = {
      url = "github:silversquirl/zig-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    zig,
    ...
  }: let
    forAllSystems = f:
      builtins.mapAttrs
      (system: pkgs: f pkgs zig.packages.${system}.zig_0_18_0_dev_1005)
      nixpkgs.legacyPackages;
  in {
    devShells = forAllSystems (pkgs: zig: {
      default = pkgs.mkShellNoCC {
        packages = [zig zig.zls];
      };
    });
  };
}
