#!/bin/bash

set -exuo pipefail

${PYTHON} -m pip install . -vv

pushd ${SP_DIR}/clidriver/lib
  # Note: Currently, we cannot strip the libraries on OSX.
  if [[ "${target_platform}" == osx-* ]]; then
    rm libDB2xml4c.58.dylib
    rm libDB2xml4c.dylib
    ln -s libDB2xml4c.58.0.dylib libDB2xml4c.58.dylib
    ln -s libDB2xml4c.58.0.dylib libDB2xml4c.dylib
  fi
  if [[ "${target_platform}" == linux-* ]]; then
    rm libDB2xml4c.so
    rm libDB2xml4c.so.58
    ln -s libDB2xml4c.so.58.0 libDB2xml4c.so.58
    ln -s libDB2xml4c.so.58.0 libDB2xml4c.so
    ${STRIP} libDB2xml4c.so.58.0
    rm libdb2.so
    ln -s libdb2.so.1 libdb2.so
    ${STRIP} libdb2.so.1
    rm libdb2clixml4c.so
    ln -s libdb2clixml4c.so.1 libdb2clixml4c.so
    ${STRIP} libdb2clixml4c.so.1

    # Strip bundled icc runtime libs
    find icc  -name '*.so' -exec ${STRIP} '{}' ';'
  fi
popd
rm -r ${SP_DIR}/ibm_db_tests
