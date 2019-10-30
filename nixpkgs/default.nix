{ system }:
let
  nixpkgs = import (builtins.fetchTarball {
    name = "nixpkgs";
    url = "https://github.com/NixOS/nixpkgs/archive/5000b1478a11acbff7d95519c7300f3e6691885d.tar.gz";
    sha256 = "0yyhkf48b15dcnq0gbiyi4ypjn09a0mpy6v7yilidwqydmkc0wxr";
  });
  haskellNixArgs = import (builtins.fetchTarball {
    name = "haskell-nix";
    url = "https://github.com/input-output-hk/haskell.nix/archive/1a28ea9ca408e0c71dade383e6877ab79091308c.tar.gz";
    sha256 = "09h8h1rmhxylxc9bdhc22mb8bskldp7y5ny57skz70myv5x3dvh0";
  });
  localHaskellNixOverlay = (
    self: super: {
      haskell-nix = super.haskell-nix // {
        stackageSourceJSON = ./stackage-src.json;
      };
    }
  );
in
  nixpkgs (haskellNixArgs // { inherit system; } //
    { overlays = haskellNixArgs.overlays ++ [ localHaskellNixOverlay ]; }
  )
