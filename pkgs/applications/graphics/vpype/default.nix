{ lib
, buildPythonPackage
, fetchFromGitHub

, asteval
, cachetools
, click
, multiprocess
, numpy
, pnoise
, scipy
, setuptools
, shapely
, svgelements
, svgwrite
, tomli

# gui dependencies
, glcontext
, matplotlib
, moderngl
, pillow
, pyside2

, poetry-core
}:

buildPythonPackage rec {
  pname = "vpype";
  version = "1.11.0-alpha.0";

  src = fetchFromGitHub {
    # https://github.com/abey79/vpype
    owner = "abey79";
    repo = "vpype";
    rev = "6a099b7b4f3d756f7fa8052049be365d0314c5ee";
    sha256 = "sha256-C15bO+Z5u29mfGULgK173AYWnYlPesdzrxPqb0j/goc=";
  };

  format = "pyproject";

  propagatedBuildInputs = [
    cachetools click multiprocess numpy pnoise shapely scipy setuptools
    svgelements svgwrite tomli asteval

    matplotlib glcontext moderngl pillow pyside2

    poetry-core
  ];

  postPatch = ''
    substituteInPlace pyproject.toml --replace 'pnoise = "^0.1.0"' 'pnoise = "^0.2.0"'
    substituteInPlace pyproject.toml --replace 'setuptools = "^51.0.0"' 'setuptools = "^61.0.0"'
  '';

  postInstall = ''
    rm $out/lib/python*/site-packages/LICENSE
    rm $out/lib/python*/site-packages/README.md
  '';

  meta = with lib; {
    description = "The Swiss Army knife of vector graphics for pen plotters";
    homepage = "https://github.com/abey79/vpype/";
    platforms = platforms.unix;
    maintainers = with maintainers; [rrix];
    license = with licenses; [ mit ];
  };
}
