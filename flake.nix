{
  description = "xv6-riscv development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;
      };
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        packages = with pkgs; [
          gnumake
          qemu
          gdb
          git
          pkgsCross.riscv64-embedded.stdenv.cc
          pkgsCross.riscv64-embedded.binutils
        ];

        shellHook = ''
          echo "xv6-riscv development environment loaded"
        '';
      };
    };
}
