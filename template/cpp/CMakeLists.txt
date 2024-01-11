# ------------------------------------------------------------------------------ 
#           File : CMakeLists.txt
#         Author : {{ tmplr.owner_name }}
#    Description : Root cmake file.
#
#                  Available targets (excluding dependencies) :
#                  * {{ tmplr.repo_name | lowercase }} : main library
#                  * tests, documentation, benchmarks are only available
#                  when build as the main project.
#
#                  Noteworthy cmake folders :
#                  * extern/ : contains cmake files to find dependencies using CPM.
#                              Can be skipped by setting {{ tmplr.repo_name | CONSTANT_CASE }}_SKIP_DEPENDENCIES 
#
#                  Noteworthy cmake options :
#                  * {{ tmplr.repo_name | CONSTANT_CASE }}_SKIP_DEPENDENCIES : skip dependencies download and build (with CPM)
#
#                  Noteworthy defines :
#                  * TRACY_ENABLE : If defined, instructions related to tracy will be included.
#                  * _NDEBUG : If undefined, some instructions specific for debugging, like
#                  vulkan validation layers and some logging, will be deactivated.
# ------------------------------------------------------------------------------ 
cmake_minimum_required (VERSION 3.17...3.26)
include(cmake/prevent_in_source_build.cmake)

# ----- Project information
project({{ tmplr.repo_name | CONSTANT_CASE }}
	DESCRIPTION "{{ tmplr.repo_desc }}"
	HOMEPAGE_URL "{{ tmplr.repo_url }}"
	LANGUAGES C CXX
)

include(cmake/project_is_top_level.cmake) # Defines PROJECT_IS_TOP_LEVEL if cmake version is under 3.21.

# Our CMake's behaviours is altered whether this project is consumed or if it is the main project
if (PROJECT_IS_TOP_LEVEL)
	set(CMAKE_CXX_EXTENSIONS OFF) # Ensure -std=c++xx is used instead of -std=g++xx. See: https://crascit.com/2015/03/28/enabling-cxx11-in-cmake/
	set_property(GLOBAL PROPERTY USE_FOLDERS ON) # Support folders in IDEs
	# Convience variable so that executables (tests, benchmarks, experiments, examples) are outputed to a specific folder.
	set(PROJECT_EXE_DIR "${CMAKE_BINARY_DIR}/bin") 
	find_package(Git)
endif ()


include(cmake/tools.cmake)
section(CHECK_START "Configuring project")

	include(cmake/git_version.cmake) # Defines version from git if is TOP_LEVEL, otherwise read it from file.
	include(cmake/version_header.cmake)

end_section(
	CONDITION ${PROJECT_NAME}_VERSION
	PASS "done. Version : ${${PROJECT_NAME}_VERSION_STRING_FULL}"
	FAIL "failed."
)


# --- Project options
option(${PROJECT_NAME}_SKIP_DEPENDENCIES "Disable automatic download of dependencies with CPM." ${PROJECT_IS_NOT_TOP_LEVEL})


# ------------------------------------------------------------------------------
# --- Dependencies
# ------------------------------------------------------------------------------
if(NOT ${${PROJECT_NAME}_SKIP_DEPENDENCIES})
	section(CHECK_START "Finding {{ tmplr.repo_name | lowercase }} dependencies")

		unset(${PROJECT_NAME}_DEPENDENCIES)
		unset(${PROJECT_NAME}_MISSING_DEPENDENCIES)

		# Add all your dependencies here (either as a subfile or directly, matter of preferences)
		include(extern/misc.cmake)

	end_section(
		CONDITION NOT ${PROJECT_NAME}_MISSING_DEPENDENCIES
		PASS "done. Dependencies : ${${PROJECT_NAME}_DEPENDENCIES}"
		FAIL "failed. Missing dependencies : ${${PROJECT_NAME}_MISSING_DEPENDENCIES}"
	)
endif()


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
    "include/{{tmplr.repo_name | lowercase }}/version.hpp"
)

# --- Assets
# No assets here

section(CHECK_START "Configuring {{tmplr.repo_name | lowercase }}")

	add_library ({{tmplr.repo_name | lowercase }} ${SOURCE_LIST} ${HEADER_LIST})
	add_library({{tmplr.repo_name | lowercase }}::{{tmplr.repo_name | lowercase }} ALIAS {{tmplr.repo_name | lowercase }})

	include(GenerateExportHeader)
	generate_export_header(
		{{tmplr.repo_name | lowercase }}
		BASE_NAME ${PROJECT_NAME}
		EXPORT_FILE_NAME export/{{tmplr.repo_name | lowercase }}/export.hpp
	)

	set_target_properties( 
		{{tmplr.repo_name | lowercase }}
		PROPERTIES
		CXX_VISIBILITY_PRESET hidden
		VISIBILITY_INLINES_HIDDEN YES
		VERSION "${PROJECT_VERSION}"
		SOVERSION "${PROJECT_VERSION_MAJOR}"
		EXPORT_NAME {{tmplr.repo_name | lowercase }}
		OUTPUT_NAME {{tmplr.repo_name | lowercase }}
	)

	target_include_directories(
		{{tmplr.repo_name | lowercase }} 
		${${PROJECT_NAME}_WARNING_GUARD} PUBLIC 
		"$<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/include>"
	)
	target_include_directories(
		{{tmplr.repo_name | lowercase }}
		SYSTEM PUBLIC
		"$<BUILD_INTERFACE:${PROJECT_BINARY_DIR}/export>"
	)

	target_link_libraries({{tmplr.repo_name | lowercase }} PUBLIC 
		misc_deps
	)

	target_compile_features({{tmplr.repo_name | lowercase }} PRIVATE cxx_std_20)
	target_compile_options({{tmplr.repo_name | lowercase }} PUBLIC $<$<CXX_COMPILER_ID:MSVC>:/Zc:preprocessor>) # if using __VA_OPT__, we enforce latest preprocessor on MSVC
	target_compile_options({{tmplr.repo_name | lowercase }} PUBLIC $<$<COMPILE_LANG_AND_ID:CXX,MSVC>:/permissive->) # being a cross-platform target, we enforce standards conformance on MSVC

	if(${PROJECT_IS_TOP_LEVEL})
	  target_set_compile_warnings_cxx(TARGET {{tmplr.repo_name | lowercase }} SCOPE PRIVATE)
	endif()


end_section( 
	CONDITION TARGET {{tmplr.repo_name | lowercase }}
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
	add_subdirectory(examples)
	add_subdirectory(docs)
endif()
