{ lib
, buildPythonPackage
, fetchFromGitHub

, poetry-core

, colorama
, cookiecutter
, matplotlib
, multiprocess
, numpy
, pnoise
, pyside2
, qasync
, shapely
, vpype
, watchfiles

, qt5
}:

let
  vpype-rev = "6a099b7b4f3d756f7fa8052049be365d0314c5ee";
in
buildPythonPackage rec {
  pname = "vsketch";
  version = "1.0.0-alpha.0";

  src = fetchFromGitHub {
    owner = "abey79";
    repo = "vsketch";
    rev = "1e9ebc540a3ef873d39e04e728a8e96a3faedb80";
    sha256 = "sha256-OhB94Vpgcl6P8dt96B+Z5EKMdO0kN/Bc95rBcF2Wd+g=";
  };

  format = "pyproject";

  nativeBuildInputs = [ qt5.wrapQtAppsHook ];
  propagatedBuildInputs = [
    vpype pnoise qasync watchfiles
    shapely numpy pyside2
    colorama cookiecutter matplotlib multiprocess

    poetry-core
  ];

  postPatch = ''
    substituteInPlace pyproject.toml --replace 'vpype = {extras = ["all"], git = "https://github.com/abey79/vpype", rev = "${vpype-rev}"}' 'vpype = "^1.11.0a0"' \

    sed -i '/PySide2/d' pyproject.toml # no idea why there isnt a dist-info written...
  '';

  dontWrapQtApps = true;
  preFixup = ''
    makeWrapperArgs+=("''${qtWrapperArgs[@]}")
  '';

  postInstall = ''
    rm $out/lib/python*/site-packages/LICENSE
    rm $out/lib/python*/site-packages/README.md
  '';

  meta = with lib; {
    description = "Plotter generative art environment";
    homepage = "https://github.com/abey79/vsketch/";
    platforms = platforms.unix;
    maintainers = with maintainers; [rrix];
    license = with licenses; [ mit ];
  };
}
