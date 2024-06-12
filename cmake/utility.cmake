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
		message("")
	endif()
endfunction()


# Define "-D${_option}" only when _option is ON.
function(option_define _target _option)
	if (${_option})
		target_compile_definitions(${_target} PUBLIC "${_option}")
	endif ()
endfunction()


# Function to begin a section. A section is a header and indent. Don't forget to call end_section() afterwards !
function(section)
	if(${PROJECT_IS_TOP_LEVEL})
		space()
		message("-----------------------------------------------")
		message(CHECK_START "[${PROJECT_NAME}] " ${ARGN})
		message("-----------------------------------------------")
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

	outdent()
	if(ARGN)
		if(${END_SECTION_CONDITION})
			message(CHECK_PASS ${END_SECTION_PASS})
		else(})
			message(CHECK_FAIL ${END_SECTION_FAIL})
		endif()
	endif()
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
