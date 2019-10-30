{ system ? builtins.currentSystem }:
let
  nixpkgs = import ./nixpkgs { inherit system; };
  hsPkgs = import ./aws-lambda-haskell-runtime-client.nix;
in
  hsPkgs nixpkgs