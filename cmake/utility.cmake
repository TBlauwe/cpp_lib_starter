# Prevent warnings from displaying when building target
# Useful when you do not want libraries warnings polluting your build output
function(suppress_warnings target)
	set_target_properties(${target} PROPERTIES INTERFACE_SYSTEM_INCLUDE_DIRECTORIES $<TARGET_PROPERTY:${target},INTERFACE_INCLUDE_DIRECTORIES>)
endfunction()


# Indent cmake message
macro(indent)
	list(APPEND CMAKE_MESSAGE_INDENT "  ${ARGN}")
endmacro()


# Outdent cmake messages
macro(outdent)
	list(POP_BACK CMAKE_MESSAGE_INDENT)
endmacro()


# Print a space
function(space)
	if(${PROJECT_IS_TOP_LEVEL})
		message(STATUS "")
	endif()
endfunction()


# Function to begin a section. A section is a header and indent. Don't forget to call end_section() afterwards !
function(section)
	if(${PROJECT_IS_TOP_LEVEL})
		space()
		message(STATUS "-----------------------------------------------")
		message(${ARGN})
		message(STATUS "-----------------------------------------------")
		space()
	else()
		message(${ARGN})
	endif()
	indent()
endfunction()


# Function to end a section. Take a condition to see if section failed or not
function(end_section)
	set(opts)
	set(one_value_args)
	set(multi_value_args PASS FAIL CONDITION)
	cmake_parse_arguments(END_SECTION "${opts}" "${one_value_args}" "${multi_value_args}" ${ARGN})

	space()
	outdent()
	if(${END_SECTION_CONDITION})
		message(CHECK_PASS ${END_SECTION_PASS})
	else()
		message(CHECK_FAIL ${END_SECTION_FAIL})
	endif()
endfunction()


# CPM Wrapper to play nicely with formatting and the use_version call. 
# Name should match with the name given in use_version.
function(download_library)
	set(opts NO_SUPPRESS_WARNINGS)
	set(one_value_args NAME GITHUB_REPOSITORY VERSION)
	set(multi_value_args OPTIONS TARGETS)
	cmake_parse_arguments(DOWNLOAD_LIBRARY "${opts}" "${one_value_args}" "${multi_value_args}" ${ARGN})

	unset(_VERSION)
	if(${DOWNLOAD_LIBRARY_VERSION})
		set(_VERSION ${DOWNLOAD_LIBRARY_VERSION})
	else()
		set(_VERSION ${CPM_${DOWNLOAD_LIBRARY_NAME}_VERSION})
	endif()

	message(CHECK_START "Finding ${DOWNLOAD_LIBRARY_NAME} [${_VERSION}] ")

	indent("(${DOWNLOAD_LIBRARY_NAME}) ")
	CPMAddPackage(
		NAME ${DOWNLOAD_LIBRARY_NAME}
		GITHUB_REPOSITORY ${DOWNLOAD_LIBRARY_GITHUB_REPOSITORY}
		GIT_TAG ${_VERSION}
		OPTIONS ${DOWNLOAD_LIBRARY_OPTIONS}
	)

	if(NOT ${${name}_ADDED})
		outdent()
		message(CHECK_FAIL "not found.")
		list(APPEND ${PROJECT_NAME}_MISSING_DEPENDENCIES "${DOWNLOAD_LIBRARY_NAME} [${_VERSION}]")
	else()
		if(NOT ${DOWNLOAD_LIBRARY_NO_SUPPRESS_WARNINGS})
			if(DOWNLOAD_LIBRARY_TARGETS)
				foreach(target ${DOWNLOAD_LIBRARY_TARGETS})
					suppress_warnings(${target})
				endforeach()
			elseif()
				suppress_warnings(${DOWNLOAD_LIBRARY_NAME})
			endif()
		endif()
		outdent()
		message(CHECK_PASS "found.")
	endif()
endfunction()


# Find package to play nicely with formatting and the use_version call. 
# Name should match with the name given in use_version.
function(find_library _NAME)
	message(CHECK_START "Finding " ${_NAME})

	indent("(${_NAME}) ")
	find_package(${_NAME})

	if(NOT ${${_NAME}_FOUND})
		outdent()
		message(CHECK_FAIL "not found.")
		list(APPEND ${PROJECT_NAME}_MISSING_DEPENDENCIES ${DOWNLOAD_LIBRARY_NAME})
	else()
		outdent()
		message(CHECK_PASS "found.")
	endif()
endfunction()


# Handy function going hand to hand with download_library. Set an option to specify
# library's version, that will be used by default by download_library
function(use_version)
	set(opts APPEND REPLACE)
	set(one_value_args NAME VERSION DESCRIPTION)
	cmake_parse_arguments(use_version "${opts}" "${one_value_args}" "" ${ARGN})

	if(${use_version_APPEND})
		set(CPM_${use_version_NAME}_VERSION ${use_version_VERSION} CACHE STRING "Git tag used to retrieve ${use_version_NAME}, if using CPM. ${use_version_DESCRIPTION}")
	elseif(${use_version_REPLACE})
		set(CPM_${use_version_NAME}_VERSION ${use_version_VERSION} CACHE STRING "${use_version_DESCRIPTION}")
	else()
		set(CPM_${use_version_NAME}_VERSION ${use_version_VERSION} CACHE STRING "Git tag used to retrieve ${use_version_NAME}, if using CPM.")
	endif()

	LIST(APPEND ${PROJECT_NAME}_CURRENT_OPTIONS CPM_${use_version_NAME}_VERSION)
	list(APPEND ${PROJECT_NAME}_DEPENDENCIES "${use_version_NAME} [${CPM_${use_version_NAME}_VERSION}]")
endfunction()


# Copy folder in_dir to out_dir before target is built.
function(add_assets target in_dir out_dir)
    add_custom_target(${target}_copy_assets
            COMMAND ${CMAKE_COMMAND} -E copy_directory
            ${in_dir} ${out_dir}
            COMMENT "(${target}) - Copying assets directory ${in_dir} to ${out_dir}"
    )
    add_dependencies(${target} ${target}_copy_assets)
endfunction()
