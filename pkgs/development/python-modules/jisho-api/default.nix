{ pkgs ? import <nixpkgs> {},
  python ? pkgs.python39 }:

python.pkgs.buildPythonPackage {
  name = "jisho-api";
  version = "0.1.8";
  format = "pyproject";

  inherit python;

  src = pkgs.fetchFromGitHub {

    owner = "pedroallenrevez";
    repo = "jisho-api";
    rev = "b80bff460a0f6826232cafce68cb75ef83543a23";
    sha256 = "sha256-3oEhr/kXesxp5vnELlciaizq88Jwzw2ahTgooA946Pc=";
  };
  
  postPatch = ''
        substituteInPlace pyproject.toml \
          --replace 'rich = "^10.11.0"' 'rich = "^12.4.4"' \
          --replace 'bs4 = "^0.0.1"' 'beautifulsoup4 = "^4.11.1"' 
      '';

  propagatedBuildInputs = with python.pkgs; [
    poetry
    click pydantic requests rich beautifulsoup4
  ];
}
