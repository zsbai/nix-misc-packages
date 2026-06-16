{
  stdenv,
  lib,
  sources,
}:
let
  p = sources.dwproton;
in
stdenv.mkDerivation {
  inherit (p) pname src;
  version = lib.removePrefix "dwproton-" p.version;

  installPhase = ''
    runHook preInstall

    mkdir -p $out
    cp -r * $out/
    find $out -xtype l -delete

    runHook postInstall
  '';

  meta = with lib; {
    description = "Proton builds with the latest Dawn Winery fixes, optimised for Asian Gacha games";
    homepage = "https://dawn.wine/dawn-winery/dwproton";
    license = licenses.bsd3;
    platforms = [ "x86_64-linux" ];
    sourceProvenance = [ sourceTypes.binaryBytecode ];
  };
}
