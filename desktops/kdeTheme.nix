{ pkgs, ... }:

let
  macTahoe = pkgs.stdenvNoCC.mkDerivation {
    pname = "mactahoe-kde";
    version = "unstable";

    src = pkgs.fetchFromGitHub {
      owner = "vinceliuice";
      repo = "MacTahoe-kde";
      rev = "main";
      hash = pkgs.lib.fakeHash;
    };

    installPhase = ''
      runHook preInstall

      mkdir -p $out/share/color-schemes
      mkdir -p $out/share/plasma/desktoptheme
      mkdir -p $out/share/plasma/layout-templates
      mkdir -p $out/share/plasma/look-and-feel
      mkdir -p $out/share/Kvantum
      mkdir -p $out/share/wallpapers
      mkdir -p $out/share/aurorae/themes

      cp -r Kvantum/MacTahoe $out/share/Kvantum/
      cp -r color-schemes/MacTahoe*.colors $out/share/color-schemes/
      cp -r plasma/desktoptheme/MacTahoe-* $out/share/plasma/desktoptheme/
      cp -r plasma/desktoptheme/icons $out/share/plasma/desktoptheme/MacTahoe-Light/
      cp -r plasma/desktoptheme/icons $out/share/plasma/desktoptheme/MacTahoe-Dark/
      cp -r plasma/layout-templates/org.github.desktop.MacOS* $out/share/plasma/layout-templates/
      cp -r plasma/look-and-feel/com.github.vinceliuice.MacTahoe-* $out/share/plasma/look-and-feel/
      cp -r wallpapers/MacTahoe* $out/share/wallpapers/

      for color in Light Dark; do
        for scale in "" "-1.25x" "-1.5x"; do
          theme="MacTahoe-$color$scale"
          mkdir -p "$out/share/aurorae/themes/$theme"

          cp -r "aurorae/$theme"/*.svg "$out/share/aurorae/themes/$theme/"
          cp -r "aurorae/''${color}rc" "$out/share/aurorae/themes/$theme/$theme""rc"
          cp -r "aurorae/icons-$color"/*.svg "$out/share/aurorae/themes/$theme/"
          cp -r aurorae/metadata.desktop aurorae/metadata.json "$out/share/aurorae/themes/$theme/"

          substituteInPlace "$out/share/aurorae/themes/$theme/metadata.desktop" \
            --replace-fail "theme_name" "$theme"

          substituteInPlace "$out/share/aurorae/themes/$theme/metadata.json" \
            --replace-fail "theme_name" "$theme"
        done
      done

      runHook postInstall
    '';
  };
in
{
  environment.systemPackages = with pkgs; [
    macTahoe
    kdePackages.qtstyleplugin-kvantum
  ];
}
