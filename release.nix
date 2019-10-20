let
  compiler = "ghc865";

  config = {
    packageOverrides = pkgs: rec {
      haskellPackages = pkgs.haskell.packages.${compiler}.override {
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
    pkgs.haskell.packages.${compiler}.callPackage ./aws-lambda-haskell-runtime-client.nix {}
  )
