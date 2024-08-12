{
  description = "rescript project flake";
  
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=24.05";
    rescript-lsp = {
      url = "github:MattBrooks95/rescript-lsp-flake";
    };
  };

  outputs = { self, nixpkgs, rescript-lsp, ... }@inputs:
  let
      forAllSystems = (function:
        nixpkgs.lib.genAttrs [
          "aarch64-darwin"
          "x86_64-linux"
        ] (system: function nixpkgs.legacyPackages.${system} system));
  in
  {
    devShells = forAllSystems(pkgs: system:
      let shell = pkgs.mkShell {
          buildInputs = with pkgs; [
            nodejs_20
            rescript-lsp.packages.${system}.default
          ];
        };
      in {
        default = shell;
      }
    );
  };
}
