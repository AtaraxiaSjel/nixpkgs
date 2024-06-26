{ lib
, buildPythonPackage
, fetchPypi
, setuptools
, ledgercomm
, packaging
, bip32
, coincurve
, typing-extensions
 }:

buildPythonPackage rec {
  pname = "ledger-bitcoin";
  version = "0.3.0";
  format = "pyproject";

  src = fetchPypi {
    inherit version;
    pname = "ledger_bitcoin";
    hash = "sha256-rZzerzOkVWK71brmdRAluGmi+B1usCZ90GKgH1klpNU=";
  };

  nativeBuildInputs = [
    setuptools
  ];

  propagatedBuildInputs = [
    ledgercomm
    packaging
    bip32
    coincurve
    typing-extensions
  ];

  pythonImportsCheck = [
    "ledger_bitcoin"
  ];

  meta = with lib; {
    description = "Client library for Ledger Bitcoin application.";
    homepage = "https://github.com/LedgerHQ/app-bitcoin-new/tree/develop/bitcoin_client/ledger_bitcoin";
    license = licenses.asl20;
  };
}
