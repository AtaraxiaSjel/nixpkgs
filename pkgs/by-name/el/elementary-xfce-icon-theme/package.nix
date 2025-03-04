{
  lib,
  stdenv,
  fetchFromGitHub,
  pkg-config,
  gdk-pixbuf,
  optipng,
  librsvg,
  gtk3,
  pantheon,
  adwaita-icon-theme,
  gnome-icon-theme,
  hicolor-icon-theme,
}:

stdenv.mkDerivation rec {
  pname = "elementary-xfce-icon-theme";
  version = "0.20";

  src = fetchFromGitHub {
    owner = "shimmerproject";
    repo = "elementary-xfce";
    rev = "v${version}";
    sha256 = "sha256-k7Bs+IyA+hHR5j17gzeL5PHlRxyKFc0wGH/MjJLDrjk=";
  };

  nativeBuildInputs = [
    pkg-config
    gdk-pixbuf
    librsvg
    optipng
    gtk3
  ];

  propagatedBuildInputs = [
    pantheon.elementary-icon-theme
    adwaita-icon-theme
    gnome-icon-theme
    hicolor-icon-theme
  ];

  dontDropIconThemeCache = true;

  postPatch = ''
    substituteInPlace svgtopng/Makefile --replace "-O0" "-O"
  '';

  postInstall = ''
    make icon-caches
  '';

  meta = with lib; {
    description = "Elementary icons for Xfce and other GTK desktops like GNOME";
    homepage = "https://github.com/shimmerproject/elementary-xfce";
    license = licenses.gpl2;
    # darwin cannot deal with file names differing only in case
    platforms = platforms.linux;
    maintainers = with maintainers; [ ] ++ teams.xfce.members;
  };
}
