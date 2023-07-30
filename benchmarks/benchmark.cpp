#include <benchmark/benchmark.h>
#include <my_lib/my_lib_header.hpp>

// Define another benchmark
static void BM_Success(benchmark::State& state) {
	for (auto _ : state)
		ml::success();
}
BENCHMARK(BM_Success);

BENCHMARK_MAIN();