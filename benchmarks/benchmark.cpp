#include <benchmark/benchmark.h>
#include <my_project/lib.hpp>

// Define another benchmark
static void BM_Success(benchmark::State& state) {
	for (auto _ : state)
		mp::success();
}
BENCHMARK(BM_Success);

BENCHMARK_MAIN();