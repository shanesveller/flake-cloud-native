{
  description = "A very basic flake";

  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.nixpkgs.url = "nixpkgs/nixpkgs-unstable";

  outputs = { self, flake-utils, nixpkgs }:
    flake-utils.lib.simpleFlake {
      inherit self nixpkgs;
      name = "cloud-native";
      overlay = ./overlay.nix;
      systems = [ "x86_64-darwin" "x86_64-linux" ];
    } // {
      defaultPackage = {
        x86_64-darwin = self.legacyPackages.x86_64-darwin.all;
        x86_64-linux = self.legacyPackages.x86_64-linux.all;
      };
      overlay = import ./overlay.nix;
    };
}
