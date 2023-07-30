# ------------------------------------------------------------------------------ 
#           File : extern/misc.cmake
#         Author : TBlauwe
#    Description : Download and build all additionnal dependencies using CPM :
#                  * tracy
#                  * fmt
#
#                  Version of each dependency can be set through options using
#                  CPM_<name>_VERSION, e.g CPM_FLECS_VERSION.
#
#                  CPM noteworthy options :
#                  * CPM_SOURCE_CACHE : download location.
#                  * CPM_USE_LOCAL_PACKAGES : search for locally installed dependencies first.
#                  * CPM_LOCAL_PACKAGES_ONLY : error if dependecy not found locally.
# ------------------------------------------------------------------------------ 
banner_2(CHECK_START "Finding misc dependencies")


# ------------------------------------------------------------------------------
# --- OPTIONS
# ------------------------------------------------------------------------------
ADD_VERSION(NAME tracy VERSION "v0.9.1")
ADD_VERSION(NAME fmt VERSION "10.0.0")
PRINT_VERSIONS()


# ------------------------------------------------------------------------------
# --- Adding libraries
# ------------------------------------------------------------------------------

# Tracy is a real time, nanosecond resolution, remote telemetry, hybrid frame 
# and sampling profiler for games and other applications.
DOWNLOAD_LIBRARY(
	NAME tracy 
	TARGETS TracyClient
	GITHUB_REPOSITORY wolfpld/tracy
)


# FMT is an open-source formatting library providing a fast and safe alternative to C stdio and C++ iostream
DOWNLOAD_LIBRARY(
  NAME fmt
  TARGETS fmt fmt-header-only
  GITHUB_REPOSITORY fmtlib/fmt
  OPTIONS
    "FMT_INSTALL OFF"
)


add_library(misc_deps INTERFACE)
target_link_libraries(misc_deps INTERFACE Tracy::TracyClient fmt-header-only)
SILENCE_WARNINGS(misc_deps)


# ------------------------------------------------------------------------------
# --- Closure
# ------------------------------------------------------------------------------
OUTDENT()
PRINT_MISSING_DEPENDENCIES()