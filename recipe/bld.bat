@echo on

cmake %SRC_DIR% ^
  -B build ^
  -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% %SRC_DIR% ^
  -DTF_BUILD_EXAMPLES=OFF ^
  -DTF_BUILD_TESTS=ON ^
  -DTF_BUILD_BENCHMARKS=OFF ^
  -DTF_BUILD_CUDA=OFF ^
  -DTF_BUILD_SYCL=OFF
if errorlevel 1 exit 1

cmake --build build --parallel --config Release
if errorlevel 1 exit 1

ctest --test-dir build --output-on-failure --build-config Release
if errorlevel 1 exit 1

cmake --build build --target install --config Release
if errorlevel 1 exit 1
