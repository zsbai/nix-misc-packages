# Nix Misc Packages 

Miscellaneous packages for my Nix Setup

## Usage

### Proton 

```nix
# Bottles
xdg.dataFile."bottles/runners/dwproton-${dwproton.version}".source = dwproton;
```

### Mods

#### Slay the Spire 2

```nix
home.file = 
let
  mods = pkgs.misc.mods.slay-the-spire-2;
  modDir = ".local/share/Steam/steamapps/common/Slay the Spire 2/mods";
in 
{
  "${modDir}/ModConfig".source = mods.modconfig;
  "${modDir}/SpeedX".source = mods.speedx;
  "${modDir}/DamageMeter".source = mods.damagemeter;
};
```

#### Clair Obscur: Expedition 33

```nix
xdg.dataFile."Steam/steamapps/common/Expedition 33/Sandfall/Binaries/Win64" = {
  source = pkgs.misc.mods.clair-obscur-fix;
  recursive = true;
};
```
