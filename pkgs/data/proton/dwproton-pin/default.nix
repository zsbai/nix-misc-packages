{
  stdenvNoCC,
  lib,
  ...
}:
stdenvNoCC.mkDerivation {
  pname = "dwproton";
  version = "11.0-4";
  src = fetchTarball {
    url = "https://dawn.wine/dawn-winery/dwproton/releases/download/dwproton-11.0-4/dwproton-11.0-4-x86_64.tar.xz";
    sha256 = "sha256-t5dLTIN+KSCQIG8spzN6soOhfCnnc+OgBoQWBdtJQFM=";
  };

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
    # maintainers = with maintainers; [ ];
  };
}
