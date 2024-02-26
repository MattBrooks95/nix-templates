{
  description = "simple flake for Haskell projects with Cabal";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=22.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        hPkgs = pkgs.haskellPackages;
        myDevTools = [
          pkgs.haskell-language-server
          hPkgs.ghc
          hPkgs.cabal-install
          hPkgs.hlint
        ];
      in {
        devShells.default = pkgs.mkShell {
          buildInputs = myDevTools;
          # Make external Nix c libraries like zlib known to GHC, like
          # pkgs.haskell.lib.buildStackProject does
          # https://github.com/NixOS/nixpkgs/blob/d64780ea0e22b5f61cd6012a456869c702a72f20/pkgs/development/haskell-modules/generic-stack-builder.nix#L38
          LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath myDevTools;
        };
      }
    );
}
