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
BANNER_2(CHECK_START "Configuring target : benchmarks")


# ------------------------------------------------------------------------------
# --- OPTIONS
# ------------------------------------------------------------------------------
ADD_VERSION(NAME benchmark VERSION "v1.8.2")
PRINT_VERSIONS()


# ------------------------------------------------------------------------------
# --- Dependencies
# ------------------------------------------------------------------------------

# A microbenchmark support library 
DOWNLOAD_LIBRARY(
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
set(SOURCE_LIST 
    "benchmark.cpp"
)

add_executable(benchmarks ${SOURCE_LIST})
target_compile_features(benchmarks PRIVATE cxx_std_20)
target_link_libraries(benchmarks PRIVATE my_lib benchmark::benchmark)
set_target_properties(benchmarks PROPERTIES OUTPUT_NAME "Benchmarks")
set_target_properties(benchmarks PROPERTIES RUNTIME_OUTPUT_DIRECTORY "${PROJECT_EXE_DIR}")

# Copy compare.py tools and its requirements for ease of use
add_custom_command(TARGET benchmarks POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E make_directory "${PROJECT_EXE_DIR}/benchmarks_tools/"
)
add_custom_command(TARGET benchmarks POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy_directory
        "${benchmark_SOURCE_DIR}/tools" "${PROJECT_EXE_DIR}/benchmarks_tools/"
)
        
# Copy run_benchmarks.py to launch benchmark
add_custom_command(TARGET benchmarks POST_BUILD
		COMMAND ${CMAKE_COMMAND} -E copy
		"${PROJECT_SOURCE_DIR}/benchmarks/tools/run_benchmarks.py"
        "${PROJECT_EXE_DIR}/"
)

# ------------------------------------------------------------------------------
# --- Closure
# ------------------------------------------------------------------------------
OUTDENT()
PRINT_MISSING_DEPENDENCIES()
