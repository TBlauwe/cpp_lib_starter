# Library files
# ==============
set(SOURCE_LIST 
    "benchmark.cpp"
)

# Dependencies
# ============
# A microbenchmark support library 
CPMAddPackage(
        NAME benchmark 
        GITHUB_REPOSITORY google/benchmark
        GIT_TAG v1.8.1
        OPTIONS
            "BENCHMARK_ENABLE_TESTING OFF"
)
if(benchmark_ADDED)
    set_target_properties(benchmark PROPERTIES CXX_STANDARD 11) # enable c++11 to avoid compilation errors
    target_compile_options(benchmark PUBLIC -D_CRT_USE_BUILTIN_OFFSETOF)
endif ()

add_executable(benchmarks ${SOURCE_LIST})
target_compile_features(benchmarks PRIVATE cxx_std_20)
target_link_libraries(benchmarks PRIVATE my_project benchmark::benchmark)
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
