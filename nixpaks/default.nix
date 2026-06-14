{ inputs, ... }:
let
  mkNixpaks =
    pkgs:
    let
      mkNixPak = inputs.nixpak.lib.nixpak {
        inherit (pkgs) lib;
        inherit pkgs;
      };

      callNixPak =
        path:
        pkgs.callPackage path {
          inherit mkNixPak;
        };
    in
    {
      discord = callNixPak ./discord.nix;
      qq = callNixPak ./qq.nix;
      materialgram = callNixPak ./materialgram.nix;
      ayugram-desktop = callNixPak ./ayugram-desktop.nix;
      termius = callNixPak ./termius.nix;
      zoom-us = callNixPak ./zoom-us.nix;
      spotify = callNixPak ./spotify.nix;
      ticktick = callNixPak ./ticktick.nix;
      feishin = callNixPak ./feishin.nix;
      cider-2 = callNixPak ./cider-2.nix;
      cherry-studio = callNixPak ./cherry-studio.nix;
      zotero = callNixPak ./zotero.nix;
    };
in
{
  flake.overlays.nixpaks = final: prev: {
    nixpaks = mkNixpaks final;
  };

  perSystem =
    { pkgs, ... }:
    let
      nixpaks = mkNixpaks pkgs;
    in
    {
      legacyPackages.nixpaks = nixpaks;
    };
}
