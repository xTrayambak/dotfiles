with import <nixpkgs> { };

mkShell {
  nativeBuildInputs = [
    openssl.dev
    qt5Full
  ];

  LD_LIBRARY_PATH = lib.makeLibraryPath [
    openssl.dev
    qt5Full
  ];
}
