# ------------------------------------------------------------------------------ 
#           File : benchmarks/CMakeList.txt
#         author : TBlauwe
#    Description : CMake file to build benchmarks using GoogleBenchmark. 
#
#                  Version of each dependency can be set through options :
#                  * CPM_GOOGLE_BENCHMARK_VERSION
#
#                  CPM noteworthy options :
#                  * CPM_SOURCE_CACHE : download location.
#                  * CPM_USE_LOCAL_PACKAGES : search for locally installed dependencies first.
#                  * CPM_LOCAL_PACKAGES_ONLY : error if dependecy not found locally.
# ------------------------------------------------------------------------------ 
section(CHECK_START "Benchmarks")


# ------------------------------------------------------------------------------
# --- Dependencies
# ------------------------------------------------------------------------------

# A microbenchmark support library 
use_version(NAME benchmark VERSION "v1.8.2")
download_library(
        NAME benchmark 
        GITHUB_REPOSITORY google/benchmark
        OPTIONS
            "BENCHMARK_ENABLE_TESTING OFF"
)
if(benchmark_ADDED)
    set_target_properties(benchmark PROPERTIES CXX_STANDARD 11) # enable c++11 to avoid compilation errors
    #target_compile_options(benchmark PUBLIC -D_CRT_USE_BUILTIN_OFFSETOF)
endif ()


# ------------------------------------------------------------------------------
# --- Target : benchmarks
# ------------------------------------------------------------------------------
set(BENCHMARKS_EXE_NAME "Benchmarks")
get_filename_component(BENCHMARKS_OUTPUT_DIR "${PROJECT_SOURCE_DIR}/benchmarks/data/" ABSOLUTE)
FILE(MAKE_DIRECTORY ${BENCHMARKS_OUTPUT_DIR})
set(SOURCE_LIST 
    "benchmark.cpp"
)

add_executable(benchmarks ${SOURCE_LIST} "scripts/continuous_benchmarking.py")
target_compile_features(benchmarks PRIVATE cxx_std_20)
target_link_libraries(benchmarks PRIVATE {{ tmplr.repo_name | lowercase }} benchmark::benchmark)
set_target_properties(benchmarks PROPERTIES OUTPUT_NAME ${BENCHMARKS_EXE_NAME})
set_target_properties(benchmarks PROPERTIES RUNTIME_OUTPUT_DIRECTORY "${PROJECT_EXE_DIR}")

# Copy google benchmark tools : compare.py and its requirements for ease of use
add_custom_command(TARGET benchmarks POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E make_directory "${PROJECT_EXE_DIR}/scripts/google_benchmark_tools"
)

add_custom_command(TARGET benchmarks POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy_directory
        "${benchmark_SOURCE_DIR}/tools" "${PROJECT_EXE_DIR}/scripts/google_benchmark_tools"
)

# ------------------------------------------------------------------------------
# --- Continuous benchmarking
# ------------------------------------------------------------------------------


# Retrieve current git tag
execute_process(
	COMMAND ${GIT_EXECUTABLE} describe --tags --abbrev=0
	WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}
	OUTPUT_VARIABLE GIT_TAG
	OUTPUT_STRIP_TRAILING_WHITESPACE
)
# Retrieve current git commit
execute_process(
	COMMAND ${GIT_EXECUTABLE} rev-parse HEAD
	WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}
	OUTPUT_VARIABLE GIT_COMMIT
	OUTPUT_STRIP_TRAILING_WHITESPACE
)

# Copy run_benchmarks.py to launch benchmark
configure_file(
		"scripts/continuous_benchmarking.py"
        "${PROJECT_EXE_DIR}/scripts/continuous_benchmarking.py"
)

add_custom_target(continuous_benchmarking
    COMMAND "continuous_benchmarking.py"
    WORKING_DIRECTORY "${PROJECT_EXE_DIR}/scripts"
    COMMENT "Launching benchmarks through python script and store results based on current configuration and git commit."
)
add_dependencies(continuous_benchmarking benchmarks)


# ------------------------------------------------------------------------------
# --- Closure
# ------------------------------------------------------------------------------

end_section(
    CONDITION TARGET benchmarks
    PASS "done."
    FAIL "failed."
)
