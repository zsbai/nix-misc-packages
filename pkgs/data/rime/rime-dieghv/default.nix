{
  sources,
  stdenvNoCC,
  lib,
}:
let
  p = sources.rime-dieghv;
in
stdenvNoCC.mkDerivation {
  inherit (p)
    pname
    version
    src
    date
    ;

  postPatch = ''
    find . -name '*.md' -delete
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out
    cp -r . $out

    runHook postInstall
  '';

  meta = {
    license = lib.licenses.gpl3Only;
    homepage = "https://github.com/kahaani/dieghv";
    description = "潮语拼音输入法 (Rime schema for Teochew dialect)";
  };
}
