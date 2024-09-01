with import <nixpkgs> { };

mkShell {
  nativeBuildInputs = [
    openssl.dev
    libappindicator
    gtk3.dev
    pkg-config
  ];

  LD_LIBRARY_PATH = lib.makeLibraryPath [
    openssl.dev
    libappindicator
    gtk3.dev
  ];
}
