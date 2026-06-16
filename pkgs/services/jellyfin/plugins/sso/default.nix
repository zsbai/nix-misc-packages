# /var/lib/jellyfin/plugins/SSO Authentication_${version}
{
  stdenvNoCC,
  sources,
  lib,
  ...
}:
let
  p = sources.jellyfin-plugin-sso;
in
stdenvNoCC.mkDerivation {
  inherit (p) version src;
  pname = "jellyfin-plugin-sso";

  installPhase = ''
    runHook preInstall

    mkdir -p $out
    cp -R . $out/

    runHook postInstall
  '';

  meta = {
    homepage = "https://github.com/Buco7854/jellyfin-plugin-sso";
    license = lib.licenses.gpl3Only;
    platform = lib.platforms.linux;
    sourceProvenance = [ lib.sourceTypes.binaryBytecode ];
  };
}
