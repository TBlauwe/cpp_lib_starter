# ----- Library files
set(SOURCE_LIST 
	"main.cpp"
    "lib.cpp"
    "utils.hpp"
)

# ----- Dependencies
# C++ testing framework
CPMAddPackage(
        NAME doctest
        GITHUB_REPOSITORY onqtam/doctest
        GIT_TAG v2.4.11
)

add_executable(tests ${SOURCE_LIST})
target_compile_features(tests PRIVATE cxx_std_20)
target_link_libraries(tests PRIVATE my_project doctest::doctest)
set_target_properties(tests PROPERTIES OUTPUT_NAME "Tests")
set_target_properties(tests PROPERTIES RUNTIME_OUTPUT_DIRECTORY "${PROJECT_EXE_DIR}")
add_test(NAME tests::doctest_all COMMAND tests)

include(${doctest_SOURCE_DIR}/scripts/cmake/doctest.cmake)
doctest_discover_tests(tests)