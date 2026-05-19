{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "weathr";
  version = "1.2.3";

  src = fetchFromGitHub {
    owner = "Veirt";
    repo = "weathr";
    # tag = "v${finalAttrs.version}";
    rev = "085b67c222c3a3a88e0ab42751205a3fc2372621";
    hash =    "sha256-fsA0zMLfPwvc4UtkiU7pu/eLQbsOoY6Kexd/AiW7wx8=";
  };
  doCheck = false;
  cargoHash = "sha256-H9Uibni+f4GQ1wq3NEk9trytkMhfP2z2mw3LpX8ss4A=";

  meta = {
    description = "A terminal weather app with ascii animation";
    homepage = "https://github.com/Veirt/weathr";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [ ];
    mainProgram = "weathr";
  };
})
