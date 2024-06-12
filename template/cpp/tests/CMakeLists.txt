# ------------------------------------------------------------------------------
#           File : tests/CMakeList.txt
#         Author : TBlauwe
#    Description : CMake file to build tests using Catch2
# ------------------------------------------------------------------------------
section("Tests")


# ------------------------------------------------------------------------------
# --- Dependencies
# ------------------------------------------------------------------------------
if(NOT TARGET Catch2::Catch2WithMain)
	CPMAddPackage("gh:catchorg/Catch2#v3.5.2")
else()
	MESSAGE(FATAL_ERROR "Catch2 not found and ${PROJECT_NAME}_DOWNLOAD_DEPENDENCIES is off.")
endif ()


# ------------------------------------------------------------------------------
# --- Target : tests
# ------------------------------------------------------------------------------
set(SOURCE_LIST 
    "core.cpp"
)

add_executable(tests ${SOURCE_LIST})
target_compile_features(tests PRIVATE cxx_std_20)
target_link_libraries(tests PRIVATE {{tmplr.repo_name | lowercase }} Catch2::Catch2WithMain)
set_target_properties(tests PROPERTIES OUTPUT_NAME "Tests")
set_target_properties(tests PROPERTIES RUNTIME_OUTPUT_DIRECTORY "${${PROJECT_NAME}_EXE_DIR}")

list(APPEND CMAKE_MODULE_PATH ${Catch2_SOURCE_DIR}/extras)
include(Catch)
catch_discover_tests(tests)

end_section()
