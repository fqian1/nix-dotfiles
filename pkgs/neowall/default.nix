{
  lib,
  stdenv,
  fetchFromGitHub,
  pkg-config,
  wayland,
  mesa,
  libpng,
  libjpeg,
  libglvnd,
  wayland-protocols,
}:

stdenv.mkDerivation rec {
  pname = "neowall";
  version = "";

  src = fetchFromGitHub {
    owner = "1ay1";
    repo = "neowall";
    rev = "494afb1e341761d97c8bee9ac07f0d391df3df58";
    sha256 = "sha256-z2nNg5xIOQM2YHQahJMW5ikCbgLTkdZkQOGBTqqEOs4=";
  };

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs = [
    wayland
    mesa
    libglvnd
    libpng
    libjpeg
    wayland-protocols
  ];

  installPhase = ''
    runHook preInstall
    install -Dm755 build/bin/neowall $out/bin/neowall
    runHook postInstall
  '';

  meta = with lib; {
    description = "🎨 A reliable Wayland wallpaper engine written in C. Multi-monitor support, smooth transitions, hot-reload. For Sway, Hyprland, River.";
    homepage = "https://github.com/1ay1/neowall";
    license = licenses.mit;
    platforms = platforms.linux;
    maintainers = [ ];
  };
}
