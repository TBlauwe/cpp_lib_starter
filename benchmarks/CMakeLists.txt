# ------------------------------------------------------------------------------ 
#           File : benchmarks/CMakeList.txt
#         Author : TBlauwe
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
# --- OPTIONS
# ------------------------------------------------------------------------------
add_version(NAME benchmark VERSION "v1.8.2")


# ------------------------------------------------------------------------------
# --- Dependencies
# ------------------------------------------------------------------------------

# A microbenchmark support library 
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
set(SOURCE_LIST 
    "benchmark.cpp"
)

add_executable(benchmarks ${SOURCE_LIST} run_benchmarks.py)
target_compile_features(benchmarks PRIVATE cxx_std_20)
target_link_libraries(benchmarks PRIVATE my_lib benchmark::benchmark)
set_target_properties(benchmarks PROPERTIES OUTPUT_NAME ${BENCHMARKS_EXE_NAME})
set_target_properties(benchmarks PROPERTIES RUNTIME_OUTPUT_DIRECTORY "${PROJECT_EXE_DIR}")

# Copy compare.py tools and its requirements for ease of use
add_custom_command(TARGET benchmarks POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E make_directory "${PROJECT_EXE_DIR}/benchmarks_tools/"
)
add_custom_command(TARGET benchmarks POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy_directory
        "${benchmark_SOURCE_DIR}/tools" "${PROJECT_EXE_DIR}/benchmarks_tools/"
)


# ------------------------------------------------------------------------------
# --- Run benchmarks tool
# ------------------------------------------------------------------------------

# Retrieve current git tag
#https://github.com/TBlauwe/card/releases/tag/1.0
execute_process(
	COMMAND ${GIT_EXECUTABLE} describe --tags --abbrev=0
	WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}
	OUTPUT_VARIABLE GIT_TAG
	OUTPUT_STRIP_TRAILING_WHITESPACE
)
# Retrieve current git commit
#https://github.com/TBlauwe/cpp_lib_starter/commit/7b79a9627de86a347a24319875006c6c000ce6f4
execute_process(
	COMMAND ${GIT_EXECUTABLE} rev-parse HEAD
	WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}
	OUTPUT_VARIABLE GIT_COMMIT
	OUTPUT_STRIP_TRAILING_WHITESPACE
)

# Copy run_benchmarks.py to launch benchmark
configure_file(
		"run_benchmarks.py"
        "${PROJECT_EXE_DIR}/run_benchmarks.py"
)


# ------------------------------------------------------------------------------
# --- Closure
# ------------------------------------------------------------------------------

end_section(
    CONDITION TARGET benchmarks
    PASS "done."
    FAIL "failed."
)
