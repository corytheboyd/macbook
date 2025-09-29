{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";

  outputs =
    { nixpkgs, ... }:
    {
      devShells.aarch64-darwin.default =
        with nixpkgs.legacyPackages.aarch64-darwin;
        mkShell {
          buildInputs = [
            nixfmt-rfc-style
          ];
        };
    };
}
