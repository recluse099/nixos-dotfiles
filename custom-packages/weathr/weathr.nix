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
    tag = "v${finalAttrs.version}";
    hash = "sha256-HZhrR3TzVLtkEGkvlKXmMVsZDu5iJ3GQOQyHL1pE7lc=";
  };
  doCheck = false;
  cargoHash = "sha256-Yn333vSD1GmLpqvtzrSJliZmtEyaDw5HmCdqnxGw3MI=";

  meta = {
    description = "A terminal weather app with ascii animation";
    homepage = "https://github.com/Veirt/weathr";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [ ];
    mainProgram = "weathr";
  };
})
