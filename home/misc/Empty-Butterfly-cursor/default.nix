{ stdenv
, lib
, unzip
, ... }:
stdenv.mkDerivation {
  name = "Empty-Butterfly-cursor";
  srcs = [
    ./Empty-Butterfly-Blue-vr6-Linux.zip
    ./Empty-Butterfly-Butter-vr6-Linux.zip
    ./Empty-Butterfly-Cyan-vr6-Linux.zip
    ./Empty-Butterfly-Green-vr6-Linux.zip
    ./Empty-Butterfly-Magenta-vr6-Linux.zip
    ./Empty-Butterfly-Orange-vr6-Linux.zip
    ./Empty-Butterfly-Purple-vr6-Linux.zip
    ./Empty-Butterfly-Red-vr6-Linux.zip
    ./Empty-Butterfly-White-vr6-Linux.zip
    ./Empty-Butterfly-Yellow-vr6-Linux.zip
  ];
  dontUnpack = true;
  dontConfigure = true;
  nativeBuildInputs = [ unzip ];
  buildCommand = ''
    mkdir -p $out/share/icons/
    for src in $srcs; do
      unzip $src
    done 
    cp -r ./Empty-Butterfly-*/Empty-Butterfly-*/ $out/share/icons/
  '';
  meta = with lib; {
    description = "Empty Butterfly cursor themes";
    homepage = "https://store.kde.org/p/2002505";
    license = [
      licenses.cc-by-sa-40
    ];
    platforms = platforms.linux;
  };
}
