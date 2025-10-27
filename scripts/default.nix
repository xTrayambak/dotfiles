{ pkgs }:

pkgs.buildNimPackage {
  pname = "scripts";
  version = "0.1.0";

  src = ./.;

  nimFlags = [ "-d:release -d:ssl" ];

  nativeBuildInputs = [ pkgs.pkg-config ];
  buildInputs = [ pkgs.openssl ];

  buildPhase = ''
    mkdir -p bin
    for f in src/*.nim; do
      name=$(basename "$f" .nim)
      nim c -d:release --out:bin/$name "$f"
    done
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp bin/* $out/bin/
  '';
}
