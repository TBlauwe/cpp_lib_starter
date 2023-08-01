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

# ------------------------------------------------------------------------------
# --- OPTIONS
# ------------------------------------------------------------------------------
add_version(NAME tracy VERSION "v0.9.1")
add_version(NAME fmt VERSION "10.0.0")


# ------------------------------------------------------------------------------
# --- Adding libraries
# ------------------------------------------------------------------------------

# Tracy is a real time, nanosecond resolution, remote telemetry, hybrid frame 
# and sampling profiler for games and other applications.
download_library(
	NAME tracy 
	TARGETS TracyClient
	GITHUB_REPOSITORY wolfpld/tracy
)

space()

# FMT is an open-source formatting library providing a fast and safe alternative to C stdio and C++ iostream
download_library(
  NAME fmt
  TARGETS fmt fmt-header-only
  GITHUB_REPOSITORY fmtlib/fmt
  OPTIONS
    "FMT_INSTALL OFF"
)


add_library(misc_deps INTERFACE)
target_link_libraries(misc_deps INTERFACE Tracy::TracyClient fmt-header-only)
suppress_warnings(misc_deps)
