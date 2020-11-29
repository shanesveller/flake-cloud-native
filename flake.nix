{
  description = "A very basic flake";

  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.nixpkgs.url = "nixpkgs/nixos-20.09";

  outputs = { self, flake-utils, nixpkgs }:
    flake-utils.lib.eachSystem [ "x86_64-darwin" "x86_64-linux" ] (system:
      let pkgs = import nixpkgs { inherit system; };
      in {
        packages = {
          flux2 = pkgs.callPackage ./flux.nix { };
          tanka = pkgs.callPackage ./tanka.nix { };
          tkn = pkgs.callPackage ./tkn.nix { };
        };

        defaultPackage = pkgs.linkFarmFromDrvs "helm-charts-packages"
          (builtins.attrValues self.packages."${system}");
      });
}
