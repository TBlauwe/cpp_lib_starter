include(CMakePrintHelpers)
include(cmake/utility.cmake)
include(cmake/target_set_compile_warnings.cmake)

if(${PROJECT_IS_TOP_LEVEL})
	find_program(CCACHE_PROGRAM ccache)
	if(CCACHE_PROGRAM)
		message(STATUS "CCache found : ${CCACHE_PROGRAM}")
		message(STATUS "Using ccache")
		set(CMAKE_C_COMPILER_LAUNCHER "${CCACHE_PROGRAM}")
		set(CMAKE_CXX_COMPILER_LAUNCHER "${CCACHE_PROGRAM}")
	else()
		message(STATUS "CCache not found - skipping.")
	endif()
endif()

if(NOT ${{{ tmplr.repo_name | CONSTANT_CASE }}_SKIP_DEPENDENCIES})
		# Dependencies are added via CPM.
		# See https://github.com/cpm-cmake/CPM.cmake for more info.
		set(CPM_DOWNLOAD_VERSION 0.38.2)
		include(cmake/cpm.cmake)
		cmake_print_variables(CPM_SOURCE_CACHE)
endif()
