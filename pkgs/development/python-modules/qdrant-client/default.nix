{ lib
, buildPythonPackage
, fetchFromGitHub
, grpcio
, grpcio-tools
, h2
, httpx
, numpy
, pytestCheckHook
, poetry-core
, pythonOlder
, typing-extensions
, urllib3
, pydantic
, portalocker
}:

buildPythonPackage rec {
  pname = "qdrant-client";
  version = "1.3.1";
  format = "pyproject";

  disabled = pythonOlder "3.7";

  src = fetchFromGitHub {
    owner = "qdrant";
    repo = pname;
    rev = "refs/tags/v${version}";
    hash = "sha256-PM/D01WCmeYLUKWwHUtCMZW6Ll3IrmKn6Oypq2y9Amo=";
  };

  nativeBuildInputs = [
    poetry-core
  ];

  propagatedBuildInputs = [
    numpy
    httpx
    grpcio
    typing-extensions
    grpcio-tools
    pydantic
    urllib3
    portalocker
    h2
  ];

  nativeCheckInputs = [
    pytestCheckHook
  ];

  pythonImportsCheck = [
    "qdrant_client"
  ];

  disabledTestPaths = [
    "tests/test_async_qdrant_client.py"
    "tests/benches/test_grpc_upload.py"
    "tests/benches/test_rest_upload.py"
    "tests/congruence_tests/"
  ];

  disabledTests = [
    # Tests require network access
    "test_alias_changes"
    "test_clear_payload"
    "test_simple_recommend_groups"
    "test_group_search_types"
    "test_single_vector"
    "test_conditional_payload_update"
    "test_delete_payload"
    "test_delete_points"
    "test_empty_vector"
    "test_get_collection"
    "test_locks"
    "test_multiple_vectors"
    "test_points_crud"
    "test_qdrant_client_integration"
    "test_quantization_config"
    "test_record_upload"
    "test_retrieve"
    "test_simple_search"
    "test_update_payload"
    "test_upload_collection"
    "test_upload_collection_generators"
    "test_upload_records"
    "test_upload_uuid_in_batches"
    "test_upsert"
  ];

  meta = with lib; {
    description = "Python client for Qdrant vector search engine";
    homepage = "https://github.com/qdrant/qdrant-client";
    changelog = "https://github.com/qdrant/qdrant-client/releases/tag/v${version}";
    license = licenses.mit;
    maintainers = with maintainers; [ happysalada ];
  };
}
