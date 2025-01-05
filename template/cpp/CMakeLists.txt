# ------------------------------------------------------------------------------ 
#           File : CMakeLists.txt
#         Author : {{ tmplr.owner_name }}
#    Description : Root cmake file.
# ------------------------------------------------------------------------------
cmake_minimum_required (VERSION 3.26)
include(cmake/prevent_in_source_build.cmake)

# ----- Project information
project({{ tmplr.repo_name | CONSTANT_CASE }}
	DESCRIPTION "{{ tmplr.repo_desc }}"
	HOMEPAGE_URL "{{ tmplr.repo_url }}"
	LANGUAGES C CXX
)


# ------------------------------------------------------------------------------
# --- CMake Modules
# ------------------------------------------------------------------------------
set(TCM_DOWNLOAD_VERSION "1.0.0")
include(cmake/get_tcm.cmake)


# ------------------------------------------------------------------------------
# --- Target : {{tmplr.repo_name | lowercase }}
# ------------------------------------------------------------------------------
# --- Sources
SET(SOURCE_LIST
    "src/core.cpp"
)

# --- Headers
SET(HEADER_LIST
    "include/{{tmplr.repo_name | lowercase }}/core.hpp"
)

add_library({{tmplr.repo_name | lowercase }} ${SOURCE_LIST} ${HEADER_LIST})
add_library({{tmplr.repo_name | lowercase }}::{{tmplr.repo_name | lowercase }} ALIAS {{tmplr.repo_name | lowercase }})

# NOTE: Warnings are ignored when project is consumed
target_include_directories({{tmplr.repo_name | lowercase }} ${{{ tmplr.repo_name | CONSTANT_CASE }}_WARNING_GUARD} PUBLIC "$<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/include>")

# Define -D {{ tmplr.repo_name | CONSTANT_CASE }}_NO_ASSERT when option {{ tmplr.repo_name | CONSTANT_CASE }}_NO_ASSERT is true.
tcm_target_options({{tmplr.repo_name | lowercase }} OPTIONS {{ tmplr.repo_name | CONSTANT_CASE }}_NO_ASSERT)

# Only for release builds
tcm_target_enable_optimisation_flags({{tmplr.repo_name | lowercase }})
tcm_target_enable_warning_flags({{tmplr.repo_name | lowercase }})
tcm_target_export_header({{tmplr.repo_name | lowercase }})

# Only if top project
tcm_benchmarks(FILES benchmarks/benchmark.cpp)
tcm_tests(FILES tests/core.cpp)
tcm_examples(FILES examples WITH_BENCHMARK)
tcm_documentation(FILES docs/pages)
