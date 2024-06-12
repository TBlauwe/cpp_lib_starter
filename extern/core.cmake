# ------------------------------------------------------------------------------
#           File : extern/core.cmake
#    Description : Find dependencies, otherwise download them using CPM :
#
#                  CPM noteworthy options :
#                  * CPM_SOURCE_CACHE           : Path to download location.
#                  * CPM_USE_LOCAL_PACKAGES     : Search for locally installed dependencies first.
#                  * CPM_LOCAL_PACKAGES_ONLY    : Error if dependency not found locally.

#         Credits: https://github.com/cpp-best-practices/cmake_template/blob/main/Dependencies.cmake
# -------------------------------------------------------------------------------

# Utility target to link dependencies
add_library(core_dependencies INTERFACE)

# ------------------------------------------------------------------------------
# --- Dependencies
# ------------------------------------------------------------------------------
# FMT is an open-source formatting library providing a fast and safe alternative to C stdio and C++ iostream
if(NOT TARGET fmt::fmt)
    CPMAddPackage(
            NAME fmt
            GIT_TAG 10.2.1
            GITHUB_REPOSITORY fmtlib/fmt
            OPTIONS
            "FMT_INSTALL OFF"
    )
    suppress_warnings(fmt)
else()
    MESSAGE(FATAL_ERROR "FMT was not found.")
endif ()
target_link_libraries(core_dependencies INTERFACE fmt::fmt)
space()
