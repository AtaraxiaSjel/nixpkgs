{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  pythonOlder,
  babel,
  gitpython,
  mkdocs,
  pytz,
  pytestCheckHook,
}:

buildPythonPackage rec {
  pname = "mkdocs-git-revision-date-localized-plugin";
  version = "1.2.9";
  format = "setuptools";

  disabled = pythonOlder "3.7";

  src = fetchFromGitHub {
    owner = "timvink";
    repo = "mkdocs-git-revision-date-localized-plugin";
    tag = "v${version}";
    hash = "sha256-1SuENREPkU9W5ldMIXDCALLMx0AiTs4dNYJYjrkaegc=";
  };

  propagatedBuildInputs = [
    babel
    gitpython
    mkdocs
    pytz
  ];

  nativeCheckInputs = [ pytestCheckHook ];

  disabledTestPaths = [ "tests/test_builds.py" ];

  pythonImportsCheck = [ "mkdocs_git_revision_date_localized_plugin" ];

  meta = with lib; {
    description = "MkDocs plugin that enables displaying the date of the last git modification of a page";
    homepage = "https://github.com/timvink/mkdocs-git-revision-date-localized-plugin";
    changelog = "https://github.com/timvink/mkdocs-git-revision-date-localized-plugin/releases/tag/v${version}";
    license = licenses.mit;
    maintainers = with maintainers; [ totoroot ];
  };
}
