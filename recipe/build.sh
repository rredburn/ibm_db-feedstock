#!/bin/bash

set -exuo pipefail

${PYTHON} -m pip install . -vv  # [win]

pushd ${SP_DIR}/clidriver/lib
  if [[ "${target_platform}" == osx-* ]]; then
    rm libDB2xml4c.58.dylib
    rm libDB2xml4c.dylib
    ln -s libDB2xml4c.58.0.dylib libDB2xml4c.58.dylib
    ln -s libDB2xml4c.58.0.dylib libDB2xml4c.dylib
  fi
popd
rm -r ${SP_DIR}/ibm_db_tests
