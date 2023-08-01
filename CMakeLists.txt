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
#                              Can be skipped by setting MYLIB_SKIP_DEPENDENCIES 
#
#                  Noteworthy cmake options :
#                  * MYLIB_SKIP_DEPENDENCIES : skip dependencies download and build (with CPM)
#
#                  Noteworthy defines :
#                  * TRACY_ENABLE : If defined, instructions related to tracy will be included.
#                  * _NDEBUG : If undefined, some instructions specific for debugging, like
#                  vulkan validation layers and some logging, will be deactivated.
# ------------------------------------------------------------------------------ 
cmake_minimum_required (VERSION 3.17...3.26)


# ------------------------------------------------------------------------------
# --- CMake configuration 
# ------------------------------------------------------------------------------
# Enable Hot Reload for MSVC compilers if supported.
if (POLICY CMP0141)
  cmake_policy(SET CMP0141 NEW)
  set(CMAKE_MSVC_DEBUG_INFORMATION_FORMAT "$<IF:$<AND:$<C_COMPILER_ID:MSVC>,$<CXX_COMPILER_ID:MSVC>>,$<$<CONFIG:Debug,RelWithDebInfo>:EditAndContinue>,$<$<CONFIG:Debug,RelWithDebInfo>:ProgramDatabase>>")
endif()


# ----- Project information
project(MYLIB
	VERSION 0.1.0
	DESCRIPTION "MY_DESC"
	HOMEPAGE_URL "https://github.com"
	LANGUAGES C CXX
)


# --- Include guard
# Only do these if this is the main project, and not if it is included through add_subdirectory
if (NOT DEFINED MYLIB_MASTER_PROJECT)
	set(MYLIB_MASTER_PROJECT OFF)
	set(MYLIB_NOT_MASTER_PROJECT ON)
	if (CMAKE_CURRENT_SOURCE_DIR STREQUAL CMAKE_SOURCE_DIR)
		set(MYLIB_MASTER_PROJECT ON)
		set(MYLIB_NOT_MASTER_PROJECT OFF)
		set(CMAKE_CXX_EXTENSIONS OFF) # Let's ensure -std=c++xx instead of -std=g++xx
		set_property(GLOBAL PROPERTY USE_FOLDERS ON) # Let's nicely support folders in IDEs
		# Convience variable so that executables (tests, benchmarks, experiments, examples) are outputed to a specific folder.
		set(PROJECT_EXE_DIR "${CMAKE_BINARY_DIR}/bin") 
	endif ()
endif ()


# ------------------------------------------------------------------------------
# --- CMake options
# ------------------------------------------------------------------------------
option(MYLIB_SKIP_DEPENDENCIES "If true, then dependencies will not be downloaded and build" ${MYLIB_NOT_MASTER_PROJECT})
option(MYLIB_VERBOSE "If true, then cmake output will be more verbose, with headers, spacing and indent." ${MYLIB_MASTER_PROJECT})


# ------------------------------------------------------------------------------
# --- CMake libraries
# ------------------------------------------------------------------------------
include(CMakePrintHelpers)
include(cmake/tools.cmake)
include(cmake/target_set_compile_warnings.cmake)

if(NOT ${MYLIB_SKIP_DEPENDENCIES})
# Dependencies are added via CPM.
# See https://github.com/cpm-cmake/CPM.cmake for more info.
	set(CPM_DOWNLOAD_VERSION 0.38.2)
	include(cmake/cpm.cmake)
endif()

if(${MYLIB_MASTER_PROJECT})
	section(CHECK_START "CMake dependencies")

	find_program(CCACHE_PROGRAM ccache)
	if(CCACHE_PROGRAM)
		message(STATUS "CCache found : ${CCACHE_PROGRAM}")
		message(STATUS "Using ccache")
		set(CMAKE_C_COMPILER_LAUNCHER "${CCACHE_PROGRAM}")
		set(CMAKE_CXX_COMPILER_LAUNCHER "${CCACHE_PROGRAM}")
	else()
		message(STATUS "CCache not found - skipping.")
	endif()

	end_section(
		CONDITION EXISTS ${CPM_DOWNLOAD_LOCATION}
		PASS "done."
		FAIL "failed."
	)
endif()


# ------------------------------------------------------------------------------
# --- Dependencies
# ------------------------------------------------------------------------------
if(NOT ${MYLIB_SKIP_DEPENDENCIES})
	section(CHECK_START "Finding my_lib dependencies")

		unset(MYLIB_DEPENDENCIES)
		unset(MYLIB_MISSING_DEPENDENCIES)
		include(extern/misc.cmake)

	end_section(
		CONDITION NOT MYLIB_MISSING_DEPENDENCIES
		PASS "done. Dependencies : ${MYLIB_DEPENDENCIES}"
		FAIL "failed. Missing dependencies : ${MYLIB_MISSING_DEPENDENCIES}"
	)
endif()


# ------------------------------------------------------------------------------
# --- Sources & Headers
# ------------------------------------------------------------------------------
SET(SOURCE_LIST
    "src/my_lib_source.cpp"
)

SET(HEADER_LIST
    "include/my_lib/my_lib_header.hpp"
)

# ------------------------------------------------------------------------------
# --- Assets
# ------------------------------------------------------------------------------
# No assets here

# ------------------------------------------------------------------------------
# --- Target : my_lib
# ------------------------------------------------------------------------------
section(CHECK_START "Configuring my_lib")

	add_library (my_lib ${SOURCE_LIST} ${HEADER_LIST})
	target_include_directories(my_lib PUBLIC include)
	target_link_libraries(my_lib PUBLIC 
		misc_deps
	)
	target_compile_features(my_lib PRIVATE cxx_std_20)
	target_compile_options(my_lib PUBLIC $<$<CXX_COMPILER_ID:MSVC>:/Zc:preprocessor>) # if using __VA_OPT__, we enforce latest preprocessor on MSVC
	target_compile_options(my_lib PUBLIC $<$<COMPILE_LANG_AND_ID:CXX,MSVC>:/permissive->) # being a cross-platform target, we enforce standards conformance on MSVC

	if(${MYLIB_MASTER_PROJECT})
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
if(${MYLIB_MASTER_PROJECT})
	include(CTest)
	add_subdirectory(tests)
	add_subdirectory(benchmarks)
	add_subdirectory(docs)
endif()
