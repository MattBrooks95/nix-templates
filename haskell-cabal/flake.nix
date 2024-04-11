{
  description = "simple flake for Haskell projects with Cabal";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=23.11";
  };

  outputs = { self, nixpkgs }:
    let
      pkgs = nixpkgs.legacyPackages."x86_64-linux";
      hPkgs = pkgs.haskellPackages;
      myDevTools = [
          # use the HLS from haskell packages, because the non haskell packages one's
          # binary name is "haskell-language-server-wrapper", which doesn't match your neovim configurations
          # "haskell-language-server" command
          hPkgs.haskell-language-server
          hPkgs.ghc
          hPkgs.cabal-install
          hPkgs.hlint
      ];
    in {
      devShells."x86_64-linux".default = pkgs.mkShell {
        buildInputs = myDevTools;
        # Make external Nix c libraries like zlib known to GHC, like
        # pkgs.haskell.lib.buildStackProject does
        # https://github.com/NixOS/nixpkgs/blob/d64780ea0e22b5f61cd6012a456869c702a72f20/pkgs/development/haskell-modules/generic-stack-builder.nix#L38
        LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath myDevTools;
      };
    };
}
