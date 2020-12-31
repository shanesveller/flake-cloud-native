final: prev: {
  cloud-native = {
    flux2 = prev.callPackage ./flux.nix { };
    nova = prev.callPackage ./nova.nix { };
    tanka = prev.callPackage ./tanka.nix { };
    tkn = prev.callPackage ./tkn.nix { };
  };
}
