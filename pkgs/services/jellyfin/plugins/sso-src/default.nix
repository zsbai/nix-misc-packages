# /var/lib/jellyfin/plugins/SSO Authentication_${version}
{
  sources,
  lib,
  buildDotnetModule,
  dotnetCorePackages,
  ...
}:
let
  p = sources.jellyfin-plugin-sso-src;
in
buildDotnetModule {
  inherit (p) src;
  pname = "jellyfin-plugin-sso";
  version = lib.removePrefix "v" p.version;

  projectFile = "SSO-Auth.sln";

  dotnet-sdk = dotnetCorePackages.sdk_9_0;

  nugetDeps = ./deps.json;

  meta = {
    homepage = "https://github.com/Buco7854/jellyfin-plugin-sso";
    license = lib.licenses.gpl3Only;
    platform = lib.platforms.linux;
  };
}
