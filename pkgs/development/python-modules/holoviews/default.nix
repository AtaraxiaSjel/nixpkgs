{
  lib,
  buildPythonPackage,
  fetchPypi,
  pythonOlder,

  # build-system
  hatch-vcs,
  hatchling,

  # dependencies
  colorcet,
  numpy,
  pandas,
  panel,
  param,
  pyviz-comms,

  # tests
  pytestCheckHook,
  pytest-asyncio,
  flaky,
}:

buildPythonPackage rec {
  pname = "holoviews";
  version = "1.20.2";
  pyproject = true;

  disabled = pythonOlder "3.9";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-jHi3mGAc468xUjZnxtHLQN+NeBJJ6+u9ssX2FDVl5tg=";
  };

  postPatch = ''
    substituteInPlace pyproject.toml \
      --replace '"ignore:No data was collected:coverage.exceptions.CoverageWarning",' ""
  '';

  build-system = [
    hatch-vcs
    hatchling
  ];

  dependencies = [
    colorcet
    numpy
    pandas
    panel
    param
    pyviz-comms
  ];

  nativeCheckInputs = [
    pytestCheckHook
    pytest-asyncio
    flaky
  ];

  disabledTests = [
    # All the below fail due to some change in flaky API
    "test_periodic_param_fn_non_blocking"
    "test_callback_cleanup"
    "test_poly_edit_callback"
    "test_launch_server_with_complex_plot"
    "test_launch_server_with_stream"
    "test_launch_simple_server"
    "test_server_dynamicmap_with_dims"
    "test_server_dynamicmap_with_stream"
    "test_server_dynamicmap_with_stream_dims"
  ];

  pythonImportsCheck = [ "holoviews" ];

  meta = {
    description = "Python data analysis and visualization seamless and simple";
    mainProgram = "holoviews";
    homepage = "https://www.holoviews.org/";
    license = lib.licenses.bsd3;
    maintainers = [ ];
  };
}
