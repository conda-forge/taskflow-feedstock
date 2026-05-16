#include <taskflow/taskflow.hpp>

#include <cstdlib>

int main() {
  tf::Executor executor;
  tf::Taskflow taskflow;

  int value = 0;
  auto [initialize, increment, scale] = taskflow.emplace(
      [&] { value = 1; },
      [&] { value += 2; },
      [&] { value *= 3; });

  initialize.precede(increment);
  increment.precede(scale);

  executor.run(taskflow).wait();

  return value == 9 ? EXIT_SUCCESS : EXIT_FAILURE;
}
