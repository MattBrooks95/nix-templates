{
  description = "template for a flake that uses flake-utils";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=22.11";
  };

  outputs = { self, nixpkgs }:
    let
      pkgs = nixpkgs.legacyPackages."x86_64-linux";
    in {
      haskell-cabal = {
        path = ./haskell-cabal;
        description = "Haskell project dependencies and dev tools with Cabal";
      };
      haskell-stack = {
        path = ./haskell-stack;
        description = "Haskell project dependencies and dev tools with Stack";
      };
    };
}
