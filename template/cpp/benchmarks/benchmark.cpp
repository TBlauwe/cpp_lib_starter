#include <benchmark/benchmark.h>
#include <{{tmplr.repo_name | lowercase}}/core.hpp>

// Define another benchmark
static void BM_Success(benchmark::State& state) {
	for (auto _ : state)
		{{tmplr.namespace}}::success();
}
BENCHMARK(BM_Success);

BENCHMARK_MAIN();