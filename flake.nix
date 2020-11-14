{
  description = "A very basic flake";

  outputs = { self, nixpkgs }:
    let pkgs = import nixpkgs { system = "x86_64-linux"; };
    in {
      packages.x86_64-linux = {
        flux2 = pkgs.callPackage ./flux.nix { };
        tanka = pkgs.callPackage ./tanka.nix { };
      };

      defaultPackage.x86_64-linux = pkgs.linkFarmFromDrvs "helm-charts-packages"
        (builtins.attrValues self.packages.x86_64-linux);
    };
}
