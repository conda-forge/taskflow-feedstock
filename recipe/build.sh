#!/bin/bash
set -e

cmake $SRC_DIR \
  ${CMAKE_ARGS} \
  -G Ninja \
  -B build \
  -DCMAKE_INSTALL_PREFIX=$PREFIX \
  -DCMAKE_BUILD_TYPE=Release \
  -DTF_BUILD_EXAMPLES=OFF \
  -DTF_BUILD_TESTS=ON \
  -DTF_BUILD_BENCHMARKS=OFF \
  -DTF_BUILD_CUDA=OFF \
  -DTF_BUILD_SYCL=OFF

cmake --build build --parallel

if [[ "${CONDA_BUILD_CROSS_COMPILATION:-}" != "1" ]]; then
  ctest --test-dir build --output-on-failure
fi

cmake --build build --target install
