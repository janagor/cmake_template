{
  description = "A C++ flake for cmake_template project";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      nixpkgs,
      flake-utils,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
        llvm = pkgs.llvmPackages_22;
      in
      {
        devShells = {
          default = pkgs.mkShell.override { stdenv = llvm.stdenv; } {
            packages = with pkgs; [
              cmake
              ninja
              gcovr
              ccache
              doxygen
              cppcheck
              graphviz
              pkg-config
              include-what-you-use

              llvm.lld
              llvm.clang
              llvm.openmp
              llvm.bintools
              llvm.compiler-rt
              llvm.clang-tools
            ];
          };
        };
      }
    );
}
