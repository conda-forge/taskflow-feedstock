cmake_minimum_required(VERSION 3.18)
project(taskflow_consumer LANGUAGES CXX)

find_package(Taskflow CONFIG REQUIRED)

add_executable(taskflow_consumer main.cpp)
target_link_libraries(taskflow_consumer PRIVATE Taskflow::Taskflow)
target_compile_features(taskflow_consumer PRIVATE cxx_std_20)

enable_testing()
add_test(NAME taskflow_consumer COMMAND taskflow_consumer)
