# ------------------------------------------------------------------------------ 
#           File : benchmarks/CMakeList.txt
#         author : TBlauwe
#    Description : CMake file to build benchmarks using GoogleBenchmark. 
# ------------------------------------------------------------------------------
section("Benchmarks")


# ------------------------------------------------------------------------------
# --- Dependencies
# ------------------------------------------------------------------------------
# A microbenchmark support library
if(NOT TARGET benchmark::benchmark)
	CPMAddPackage(
			NAME gbench
			GIT_TAG "v1.8.3"
			GITHUB_REPOSITORY google/benchmark
			OPTIONS
			"BENCHMARK_ENABLE_TESTING OFF"
	)
	if(gbench)
		set_target_properties(gbench PROPERTIES CXX_STANDARD 11) # enable c++11 to avoid compilation errors
	endif ()
else()
	MESSAGE(FATAL_ERROR "Google benchmark not found and ${PROJECT_NAME}_DOWNLOAD_DEPENDENCIES is off.")
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
set_target_properties(benchmarks PROPERTIES RUNTIME_OUTPUT_DIRECTORY "${${PROJECT_NAME}_EXE_DIR}")

# Copy google benchmark tools : compare.py and its requirements for ease of use
add_custom_command(TARGET benchmarks POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E make_directory "${${PROJECT_NAME}_EXE_DIR}/scripts/google_benchmark_tools"
)

add_custom_command(TARGET benchmarks POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy_directory
        "${benchmark_SOURCE_DIR}/tools" "${${PROJECT_NAME}_EXE_DIR}/scripts/google_benchmark_tools"
)

# ------------------------------------------------------------------------------
# --- Continuous benchmarking
# ------------------------------------------------------------------------------

# Try to get the current tag name
execute_process(
	COMMAND ${GIT_EXECUTABLE} describe --exact-match --tags
	WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}
	OUTPUT_VARIABLE GIT_COMMIT
	OUTPUT_STRIP_TRAILING_WHITESPACE
	RESULT_VARIABLE GIT_RESULT
)

# If the tag name is not found, get the latest commit hash
if(NOT GIT_RESULT EQUAL 0)
	execute_process(
		COMMAND ${GIT_EXECUTABLE} rev-parse HEAD
		WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}
		OUTPUT_VARIABLE GIT_COMMIT
		OUTPUT_STRIP_TRAILING_WHITESPACE
	)
endif()


# Copy run_benchmarks.py to launch benchmark
configure_file(
		"scripts/continuous_benchmarking.py"
        "${${PROJECT_NAME}_EXE_DIR}/scripts/continuous_benchmarking.py"
)

add_custom_target(continuous_benchmarking
    COMMAND "continuous_benchmarking.py"
    WORKING_DIRECTORY "${${PROJECT_NAME}_EXE_DIR}/scripts"
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
