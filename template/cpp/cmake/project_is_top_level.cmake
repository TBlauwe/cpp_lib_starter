# Adapted from: https://github.com/friendlyanon/cmake-init-shared-static/blob/master/cmake/project-is-top-level.cmake

# CMake 3.21 added a boolean variable "PROJECT_IS_TOP_LEVEL".
# To support older version, this file can be included to simulate the behaviour of this variable (modulo bugs).
if(CMAKE_VERSION VERSION_LESS 3.21)
	string(
		COMPARE EQUAL
		"${CMAKE_SOURCE_DIR}" "${PROJECT_SOURCE_DIR}"
		PROJECT_IS_TOP_LEVEL
	)
endif()

# I couldn't find a way to negate a boolean in place, when calling a macro.
if(PROJECT_IS_TOP_LEVEL)
	set(PROJECT_IS_NOT_TOP_LEVEL FALSE) 
else()
	set(PROJECT_IS_NOT_TOP_LEVEL TRUE) 
endif()

