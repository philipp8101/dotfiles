{ pkgs, ... }:
pkgs.stdenv.mkDerivation {
  name = "i3-scripts";
  src = ./.;
  buildInputs = with pkgs; [ gnused python311 python311Packages.i3ipc ];
  buildCommand = ''
    mkdir -p $out/bin
    cp $src/*py $out/bin/
    chmod +x $out/bin/*
    sed -i -e '1i #!${pkgs.python312}/bin/python' $out/bin/*
  '';
}
