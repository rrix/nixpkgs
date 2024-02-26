{ lib
, stdenv
, buildPythonPackage
, django
, fetchFromGitHub
, pkgs
, poetry-core
, pytest-django
, pytestCheckHook
, pythonOlder
, setuptools
}:

buildPythonPackage rec {
  pname = "django-htmx";
  version = "1.17.1";
  pyproject = true;

  disabled = pythonOlder "3.8";

  src = fetchFromGitHub {
    owner = "adamchainz";
    repo = "django-htmx";
    rev = "refs/tags/${version}";
    hash = "sha256-nsJRydUcKzIskCxWk5iQu5F7gUz0BWNY3mHmmQhep64=";
  };

  nativeBuildInputs = [
    poetry-core
    setuptools
  ];

  propagatedBuildInputs = [
    django
  ];

  nativeCheckInputs = [
    pytest-django
    pytestCheckHook
  ];

  pythonImportsCheck = [
    "django_htmx"
  ];

  meta = with lib; {
    description = "Extensions for using Django with htmx.";
    homepage = "https://django-htmx.readthedocs.org";
    changelog = "https://github.com/adamchainz/django-htmx/releases/tag/v${version}";
    license = licenses.mit;
    maintainers = with maintainers; [ rrix ];
  };
}
