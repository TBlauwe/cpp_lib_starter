# ------------------------------------------------------------------------------ 
#           File : CMakeLists.txt
#         Author : TBlauwe
#    Description : Root cmake file.
#
#                  Available targets (excluding dependencies) :
#                  * mylib : main library
#                  * tests, documentation, benchmarks are only available
#                  when build as the main project.
#
#                  Noteworthy cmake folders :
#                  * extern/ : contains cmake files to find dependencies using CPM.
#                              Can be skipped by setting MY_LIB_SKIP_DEPENDENCIES 
#
#                  Noteworthy cmake options :
#                  * MY_LIB_SKIP_DEPENDENCIES : skip dependencies download and build (with CPM)
#
#                  Noteworthy defines :
#                  * TRACY_ENABLE : If defined, instructions related to tracy will be included.
#                  * _NDEBUG : If undefined, some instructions specific for debugging, like
#                  vulkan validation layers and some logging, will be deactivated.
# ------------------------------------------------------------------------------ 
cmake_minimum_required (VERSION 3.17...3.26)
include(cmake/prevent_in_source_build.cmake)

# ----- Project information
project(MY_LIB
	VERSION 0.1.0
	DESCRIPTION "Repository template for C++ projects"
	HOMEPAGE_URL "https://github.com/TBlauwe/cpp_lib_starter"
	LANGUAGES C CXX
)

include(cmake/project_is_top_level.cmake) # Defines PROJECT_IS_TOP_LEVEL if cmake version is under 3.21.

# Our CMake's behaviours is altered whether this project is consumed or if it is the main project
if (PROJECT_IS_TOP_LEVEL)
	set(CMAKE_CXX_EXTENSIONS OFF) # Ensure -std=c++xx is used instead of -std=g++xx. See: https://crascit.com/2015/03/28/enabling-cxx11-in-cmake/
	set_property(GLOBAL PROPERTY USE_FOLDERS ON) # Support folders in IDEs
	# Convience variable so that executables (tests, benchmarks, experiments, examples) are outputed to a specific folder.
	set(PROJECT_EXE_DIR "${CMAKE_BINARY_DIR}/bin") 
endif ()

# --- Project options
option(MY_LIB_SKIP_DEPENDENCIES "Disable automatic download of dependencies with CPM." ${PROJECT_IS_NOT_TOP_LEVEL})
option(MY_LIB_VERBOSE "Enable a more verbose CMake's output, with headers, spacing and indent." ${PROJECT_IS_TOP_LEVEL})


# --- CMake tools
include(cmake/tools.cmake)


# ------------------------------------------------------------------------------
# --- Dependencies
# ------------------------------------------------------------------------------
if(NOT ${MY_LIB_SKIP_DEPENDENCIES})
	section(CHECK_START "Finding my_lib dependencies")

		unset(MY_LIB_DEPENDENCIES)
		unset(MY_LIB_MISSING_DEPENDENCIES)
		include(extern/misc.cmake)

	end_section(
		CONDITION NOT MY_LIB_MISSING_DEPENDENCIES
		PASS "done. Dependencies : ${MY_LIB_DEPENDENCIES}"
		FAIL "failed. Missing dependencies : ${MY_LIB_MISSING_DEPENDENCIES}"
	)
endif()


# ------------------------------------------------------------------------------
# --- Target : my_lib
# ------------------------------------------------------------------------------
# --- Sources
SET(SOURCE_LIST
    "src/my_lib_source.cpp"
)

# --- Headers
SET(HEADER_LIST
    "include/my_lib/my_lib_header.hpp"
)

# --- Assets
# No assets here

section(CHECK_START "Configuring my_lib")

	add_library (my_lib ${SOURCE_LIST} ${HEADER_LIST})
	target_include_directories(my_lib PUBLIC include)
	target_link_libraries(my_lib PUBLIC 
		misc_deps
	)
	target_compile_features(my_lib PRIVATE cxx_std_20)
	target_compile_options(my_lib PUBLIC $<$<CXX_COMPILER_ID:MSVC>:/Zc:preprocessor>) # if using __VA_OPT__, we enforce latest preprocessor on MSVC
	target_compile_options(my_lib PUBLIC $<$<COMPILE_LANG_AND_ID:CXX,MSVC>:/permissive->) # being a cross-platform target, we enforce standards conformance on MSVC

	if(${PROJECT_IS_TOP_LEVEL})
	  target_set_compile_warnings_cxx(TARGET my_lib SCOPE PRIVATE)
	endif()

end_section( 
	CONDITION TARGET my_lib
	PASS "done."
	FAIL "failed."
)


# ------------------------------------------------------------------------------
# --- Additional targets : tests, benchmarks.
# ------------------------------------------------------------------------------
# Only available if this is the main project
if(${PROJECT_IS_TOP_LEVEL})
	include(CTest)
	add_subdirectory(tests)
	add_subdirectory(benchmarks)
	add_subdirectory(docs)
endif()
