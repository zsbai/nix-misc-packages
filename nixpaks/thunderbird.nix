{
  lib,
  package ? pkgs.thunderbird,
  pkgs,
  mkNixPak,
  buildEnv,
  makeDesktopItem,
  gpgDir ? ".gnupg",
  dotDir ? ".thunderbird",
  thunderbirdDir ? "thunderbird",
  ...
}:
let
  appId = "org.mozilla.Thunderbird";

  wrapped = mkNixPak {
    config =
      { sloth, ... }:
      {
        app = {
          inherit package;
        };
        flatpak.appId = appId;
        flatpakDataDir = false;

        imports = [
          ./modules/gui-base.nix
          ./modules/network.nix
          ./modules/common.nix
        ];

        bubblewrap = {
          bind.rw = [
            [
              # https://bugzilla.mozilla.org/show_bug.cgi?id=2007074
              (sloth.mkdir (sloth.concat' sloth.homeDir "/${thunderbirdDir}"))
              (sloth.mkdir (sloth.concat' sloth.homeDir "/thunderbird"))
            ]
            [
              (sloth.mkdir (sloth.concat' sloth.homeDir "/${dotDir}"))
              (sloth.concat' sloth.homeDir "/.thunderbird")
            ]
            (sloth.concat' sloth.xdgCacheHome "/thunderbird")
          ];
          bind.ro = [
            "/sys/bus/pci"
            # [
            #   "${package}/lib/thunderbird"
            #   "/app/etc/thunderbird"
            # ]
            "/etc/thunderbird"

            # ================ for browserpass extension ===============================
            "/etc/gnupg"
            (sloth.concat' sloth.homeDir gpgDir) # gpg's config
            (sloth.concat' sloth.runtimeDir "/gnupg") # for access gpg-agent socket

            # Unsure
            (sloth.concat' sloth.xdgConfigHome "/dconf")
          ];
          sockets = {
            x11 = false;
            wayland = true;
            pipewire = true;
          };
        };
      };
  };
  exePath = lib.getExe wrapped.config.script;
in
buildEnv {
  inherit (wrapped.config.script) name meta passthru;
  paths = [
    wrapped.config.script
    (makeDesktopItem {
      name = appId;
      desktopName = "Thunderbird";
      genericName = "Email Client";
      comment = "Read and write e-mails or RSS feeds, or manage tasks on calendars.";
      exec = "${exePath} %U";
      terminal = false;
      icon = "thunderbird";
      startupNotify = true;
      startupWMClass = "thunderbird";
      type = "Application";
      categories = [
        "Chat"
        "Network"
        "Email"
        "Feed"
        "GTK"
        "News"
      ];
      mimeTypes = [
        "message/rfc822"
        "x-scheme-handler/mailto"
        "text/calendar"
        "text/x-vcard"
      ];
      actions = {
        profile-manager-window = {
          name = "Profile Manager";
          exec = "${exePath} --ProfileManager";
        };
      };
      extraConfig = {
        X-Flatpak = appId;
      };
    })
  ];
}
