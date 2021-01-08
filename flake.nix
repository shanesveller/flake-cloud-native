{
  description = "A very basic flake";

  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.nixpkgs.url = "nixpkgs/nixos-20.09";

  outputs = { self, flake-utils, nixpkgs }:
    flake-utils.lib.simpleFlake {
      inherit self nixpkgs;
      name = "cloud-native";
      overlay = ./overlay.nix;
      systems = [ "x86_64-darwin" "x86_64-linux" ];
    } // {
      overlay = import ./overlay.nix;
    };
}
