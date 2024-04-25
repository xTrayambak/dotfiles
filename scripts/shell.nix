with import <nixpkgs> { };

mkShell {
  nativeBuildInputs = [
    openssl.dev
  ];

  LD_LIBRARY_PATH = lib.makeLibraryPath [
    openssl.dev
  ];
}
