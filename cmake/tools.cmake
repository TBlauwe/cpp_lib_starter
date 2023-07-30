# Prevent warnings from displaying when building target
# Useful when you do not want libraries warnings polluting your build output
macro(silence_warnings target)
	message(STATUS "Trying to suppress build warnings for target : ${target}.")
	set_target_properties(${target} PROPERTIES INTERFACE_SYSTEM_INCLUDE_DIRECTORIES $<TARGET_PROPERTY:${target},INTERFACE_INCLUDE_DIRECTORIES>)
endmacro()


# Handy function to indent cmake message
macro(indent)
	list(APPEND CMAKE_MESSAGE_INDENT "  ${ARGN}")
endmacro()


# Handy function to outdent cmake message
macro(outdent)
	list(POP_BACK CMAKE_MESSAGE_INDENT)
endmacro()


# Handy function to outdent cmake message
macro(space)
	message(STATUS "")
endmacro()


# Handy function to print a header and indent. Don't forget to call outdent() afterwards !
macro(banner_2)
	space()
	message(STATUS "-----------------------------------------------")
	message(${ARGN})
	message(STATUS "-----------------------------------------------")
	space()
	indent()
endmacro()


# Handy function to print current missing dependencies.
macro(print_missing_dependencies)
	space()
	if(missing_components)
		message(CHECK_FAIL "missing dependencies: ${missing_components}")
	else()
		message(CHECK_PASS "ALL DEPENDENCIES FOUND")
	endif()
endmacro()


# CPM Wrapper to play nicely with formatting and the add_version call. 
# Name should match with the name given in add_version.
macro(download_library)
	set(opts NO_SILENCE_WARNINGS)
	set(one_value_args NAME GITHUB_REPOSITORY VERSION)
	set(multi_value_args OPTIONS TARGETS)
	cmake_parse_arguments(DOWNLOAD_LIBRARY "${opts}" "${one_value_args}" "${multi_value_args}" ${ARGN})

	space()
	message(CHECK_START "Finding ${DOWNLOAD_LIBRARY_NAME}")
	indent("(${DOWNLOAD_LIBRARY_NAME}) ")
	if(${DOWNLOAD_LIBRARY_VERSION})
		CPMAddPackage(
			NAME ${DOWNLOAD_LIBRARY_NAME}
			GITHUB_REPOSITORY ${DOWNLOAD_LIBRARY_GITHUB_REPOSITORY}
			GIT_TAG ${DOWNLOAD_LIBRARY_VERSION}
			OPTIONS ${DOWNLOAD_LIBRARY_OPTIONS}
		)
	else()
		CPMAddPackage(
			NAME ${DOWNLOAD_LIBRARY_NAME}
			GITHUB_REPOSITORY ${DOWNLOAD_LIBRARY_GITHUB_REPOSITORY}
			GIT_TAG ${CPM_${DOWNLOAD_LIBRARY_NAME}_VERSION}
			OPTIONS ${DOWNLOAD_LIBRARY_OPTIONS}
		)
	endif()
	if(NOT ${${name}_ADDED})
		outdent()
		message(CHECK_FAIL "not found.")
		list(APPEND missing_components ${DOWNLOAD_LIBRARY_NAME})
	else()
		if(NOT ${DOWNLOAD_LIBRARY_NO_SILENCE_WARNINGS})
			if(DOWNLOAD_LIBRARY_TARGETS)
				foreach(target ${DOWNLOAD_LIBRARY_TARGETS})
					silence_warnings(${target})
				endforeach()
			elseif()
				silence_warnings(${DOWNLOAD_LIBRARY_NAME})
			endif()
		endif()
		outdent()
		message(CHECK_PASS "found.")
	endif()
endmacro()


# Handy function going hand to hand with download_library. Set an option to specify
# library's version, that will be used by default by download_library
macro(add_version)
	set(opts APPEND REPLACE)
	set(one_value_args NAME VERSION DESCRIPTION)
	cmake_parse_arguments(ADD_VERSION "${opts}" "${one_value_args}" "" ${ARGN})


	if(${ADD_VERSION_APPEND})
		set(CPM_${ADD_VERSION_NAME}_VERSION ${ADD_VERSION_VERSION} CACHE STRING "Git tag used to retrieve ${ADD_VERSION_NAME}, if using CPM. ${ADD_VERSION_DESCRIPTION}")
	elseif(${ADD_VERSION_REPLACE})
		set(CPM_${ADD_VERSION_NAME}_VERSION ${ADD_VERSION_VERSION} CACHE STRING "${ADD_VERSION_DESCRIPTION}")
	else()
		set(CPM_${ADD_VERSION_NAME}_VERSION ${ADD_VERSION_VERSION} CACHE STRING "Git tag used to retrieve ${ADD_VERSION_NAME}, if using CPM.")
	endif()

	LIST(APPEND current_options CPM_${ADD_VERSION_NAME}_VERSION)

endmacro()


# Print current versions of libraries added by add_version. Clear list afterwards
macro(print_versions)
	message(STATUS "Versions :")
	indent()
	foreach(opt ${current_options})
		cmake_print_variables(${opt})
	endforeach()
	outdent()
	unset(current_options)
endmacro()
