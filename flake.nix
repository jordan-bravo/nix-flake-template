{
  description = "A template flake for creating a Nix development environment";

  # URLs for the Nix inputs to use
  inputs = {
    # The largest repository of Nix packages
    nixpkgs.url = "github:NixOS/nixpkgs";
    # Helper functions for using flakes
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        devShells.default = pkgs.mkShell {
          # Packages included in the environment
          buildInputs = with pkgs; [
            cowsay
            hello
          ];

          # Run when the shell is started up
          shellHook = with pkgs; ''
            						MY_VARIABLE=moo
                        echo " `${cowsay}/bin/cowsay $MY_VARIABLE`"
          '';
        };
      });
}
