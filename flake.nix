{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  
  outputs = { nixpkgs, ... }: {
    devShells.aarch64-darwin.default = with nixpkgs.legacyPackages.aarch64-darwin; mkShell {
      buildInputs = [ nodejs_22 python313 ];
    };
  };
}