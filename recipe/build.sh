#!/bin/bash
set -e

if [[ ${cuda_compiler_version} != "None" ]]; then
  BUILD_CUDA=ON
else
  BUILD_CUDA=OFF
fi

if [[ "${target_platform}" == osx-arm64 ]]; then
  BUILD_TESTS=OFF
else
  BUILD_TESTS=ON
fi

cmake $SRC_DIR \
  ${CMAKE_ARGS} \
  -G Ninja \
  -B build \
  -DCMAKE_INSTALL_PREFIX=$PREFIX \
  -DCMAKE_BUILD_TYPE=Release \
  -DTF_BUILD_EXAMPLES=OFF \
  -DTF_BUILD_TESTS=$BUILD_TESTS \
  -DTF_BUILD_BENCHMARKS=OFF \
  -DTF_BUILD_CUDA=$BUILD_CUDA \
  -DTF_BUILD_SYCL=OFF

cmake --build build --parallel

if [[ "${cuda_compiler_version}" == "None" && "${CONDA_BUILD_CROSS_COMPILATION:-}" != "1" ]]; then
  ctest --test-dir build --output-on-failure
fi

cmake --build build --target install
