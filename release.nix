let
  config = {
    packageOverrides = pkgs: rec {
      haskellPackages = pkgs.haskellPackages.override {
        overrides = haskellPackagesNew: haskellPackagesOld: rec {
          dhall =
            haskellPackagesNew.callPackage ./nix/dhall.nix { };
          generic-random = 
            haskellPackagesNew.callPackage ./nix/generic-random.nix { };
        };
      };
    };
  };

  pkgs = import <nixpkgs> { inherit config; };

in pkgs.haskell.lib.justStaticExecutables (
    pkgs.haskellPackages.callPackage ./aws-lambda-haskell-runtime-client.nix {}
  )
