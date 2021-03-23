final: prev: {
  cloud-native = {
    all = prev.linkFarmFromDrvs "flake-cloud-native"
      (with final.cloud-native; [ flux2 nova tanka tkn ]);
    flux2 = prev.fluxcd;
    nova = prev.callPackage ./nova.nix { };
    tanka = prev.callPackage ./tanka.nix { };
    tkn = prev.callPackage ./tkn.nix { };
  };
}
