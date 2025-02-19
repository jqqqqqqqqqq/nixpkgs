{ stdenv
, lib
, fetchFromGitHub
, wrapGAppsHook4
, libadwaita
, meson
, ninja
, gettext
, gtk4
, appstream-glib
, desktop-file-utils
, gobject-introspection
, blueprint-compiler
, pkg-config
, json-glib
, libsoup_3
, glib
, libbacktrace
, python3
, text-engine
}:

stdenv.mkDerivation rec {
  pname = "gnome-extension-manager";
  version = "0.4.0";

  src = fetchFromGitHub {
    owner = "mjakeman";
    repo = "extension-manager";
    rev = "v${version}";
    sha256 = "sha256-M+jMEJXtzUP6dQp9vpyMhh1wuKG9YJ8i0ys92nbmmpw=";
  };

  nativeBuildInputs = [
    appstream-glib
    desktop-file-utils
    gettext
    glib
    gobject-introspection
    libadwaita
    meson
    ninja
    pkg-config
    python3
    wrapGAppsHook4
  ];

  buildInputs = [
    blueprint-compiler
    gtk4
    json-glib
    libsoup_3
    libbacktrace
    text-engine
  ];

  # See https://github.com/NixOS/nixpkgs/issues/36468.
  mesonFlags = [ "-Dc_args=-I${glib.dev}/include/gio-unix-2.0" ];

  meta = with lib; {
    description = "Desktop app for managing GNOME shell extensions";
    homepage = "https://github.com/mjakeman/extension-manager";
    license = licenses.gpl3Plus;
    platforms = platforms.linux;
    maintainers = with maintainers; [ foo-dogsquared ];
  };
}
