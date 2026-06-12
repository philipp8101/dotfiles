{ stdenvNoCC
, fetchFromGitHub
, formats
, themeConfig ? {}
}: let
user-cfg = (formats.ini { }).generate "theme.conf.user" themeConfig;
in stdenvNoCC.mkDerivation {
    name = "sddm-noctalia";
    version = "1.0.0";
    src = fetchFromGitHub {
        owner = "Vorxiu";
        repo = "sddm-noctalia";
        rev = "noctalia";
        hash = "sha256-5TFN4gdyjtdhE4kFpv+XWhKatsZ2vb8JABwIBIMdNpM=";
    };
    installPhase = ''
        runHook preInstall
        mkdir -p "$out/share/sddm/themes"
        cp -r ./ "$out/share/sddm/themes/Noctalia"

        cp ${./theme.conf} $out/share/sddm/themes/Noctalia/theme.conf
        runHook postInstall
    '';
}
