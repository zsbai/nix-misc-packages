{
  lib,
  pcre2,
  sources,
  stdenv,
  xmake,
}:
let
  p = sources.danmakufactory;
in
stdenv.mkDerivation {
  pname = "danmakufactory";
  version = "2.0.0-unstable-${p.date}";
  inherit (p) src;

  patches = [ ./use-system-pcre2.patch ];

  nativeBuildInputs = [ xmake ];
  buildInputs = [ pcre2 ];

  configurePhase = ''
    runHook preConfigure

    export HOME="$TMPDIR"
    xmake f -m release -y

    runHook postConfigure
  '';

  buildPhase = ''
    runHook preBuild

    xmake build -j "$NIX_BUILD_CORES" -v -y

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    xmake install -o "$out" -y
    mv "$out/bin/source" "$out/bin/DanmakuFactory"

    runHook postInstall
  '';

  meta = {
    description = "Convert danmaku files between ASS, XML and JSON formats";
    homepage = "https://github.com/hihkm/DanmakuFactory";
    license = lib.licenses.mit;
    mainProgram = "DanmakuFactory";
    platforms = with lib.platforms; linux ++ darwin;
    sourceProvenance = [ lib.sourceTypes.fromSource ];
  };
}
