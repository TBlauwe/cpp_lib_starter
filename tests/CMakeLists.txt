# ------------------------------------------------------------------------------ 
#           File : tests/CMakeList.txt
#         Author : TBlauwe
#    Description : CMake file to build tests using doctest.
#
#                  Version of each dependency can be set through options :
#                  * CPM_DOCTEST_VERSION
#
#                  CPM noteworthy options :
#                  * CPM_SOURCE_CACHE : download location.
#                  * CPM_USE_LOCAL_PACKAGES : search for locally installed dependencies first.
#                  * CPM_LOCAL_PACKAGES_ONLY : error if dependecy not found locally.
# ------------------------------------------------------------------------------ 
section(CHECK_START "Tests")


# ------------------------------------------------------------------------------
# --- OPTIONS
# ------------------------------------------------------------------------------
add_version(NAME doctest VERSION "v2.4.11")


# ------------------------------------------------------------------------------
# --- Adding libraries
# ------------------------------------------------------------------------------

# Doctest is the fastest feature-rich C++11/14/17/20/23 single-header testing framework
download_library(
	NAME doctest
	GITHUB_REPOSITORY onqtam/doctest
)


# ------------------------------------------------------------------------------
# --- Target : tests
# ------------------------------------------------------------------------------
set(SOURCE_LIST 
	"main.cpp"
    "utils.hpp"
    "my_lib_header.cpp"
)

add_executable(tests ${SOURCE_LIST})
target_compile_features(tests PRIVATE cxx_std_20)
target_link_libraries(tests PRIVATE my_lib doctest::doctest)
set_target_properties(tests PROPERTIES OUTPUT_NAME "Tests")
set_target_properties(tests PROPERTIES RUNTIME_OUTPUT_DIRECTORY "${PROJECT_EXE_DIR}")
add_test(NAME tests::doctest_all COMMAND tests)

include(${doctest_SOURCE_DIR}/scripts/cmake/doctest.cmake)
doctest_discover_tests(tests)

end_section(
    CONDITION TARGET tests
    PASS "done."
    FAIL "failed."
)
