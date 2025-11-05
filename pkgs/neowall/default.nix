self: super: {
  neowall = super.stdenv.mkDerivation rec {
    pname = "neowall";
    version = "unstable-2024-05-22"; # Use date of latest commit

    src = super.fetchFromGitHub {
      owner = "1ay1";
      repo = "neowall";
      rev = "386243d053ca42879ab6873265d3d53a996265d3"; # Latest commit hash as of writing
      hash = "sha256-2333333333333333333333333333333333333333333333333333"; # Replace with actual hash
    };

    nativeBuildInputs = [
      super.make
      super.pkg-config
    ];

    buildInputs = [
      super.wayland
      super.mesa
      super.libpng
      super.libjpeg
      super.wayland-protocols
    ];

    installPhase = ''
      runHook preInstall
      make install PREFIX=$out
      runHook postInstall
    '';

    meta = with super.lib; {
      description = "GPU shaders as Wayland wallpapers";
      homepage = "https://github.com/1ay1/neowall";
      license = licenses.mit;
      maintainers = with maintainers; [ your-github-username ]; # Replace with your username
      platforms = platforms.linux;
      mainProgram = "neowall";
    };
  };
}
