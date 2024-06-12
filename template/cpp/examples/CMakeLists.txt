# ------------------------------------------------------------------------------ 
#           File : examples/CMakeList.txt
#    Description : CMake file to build examples.
# ------------------------------------------------------------------------------
section("Examples")

# ------------------------------------------------------------------------------
# --- Target : Build examples
# ------------------------------------------------------------------------------
file (GLOB_RECURSE examples CONFIGURE_DEPENDS "*.cpp")

foreach (example IN LISTS examples)
	# Get the relative path of the file from the examples folder
	# (e.g. 'foo/bar.cpp' from 'examples/foo/bar.cpp')
	file(RELATIVE_PATH relative_path "${CMAKE_SOURCE_DIR}/examples" "${example}")

	# Replace the slashes and dots with underscores to get a valid target name
	# (e.g. 'foo_bar_cpp' from 'foo/bar.cpp')
	string(REPLACE "/" "_" target_name ${relative_path})
	string(REPLACE "\\" "_" target_name ${target_name})
	string(REPLACE ".cpp" "" target_name ${target_name})
	message(STATUS "Building example : ${target_name}")

	add_executable(${target_name} ${example})
	target_compile_features(${target_name} PRIVATE cxx_std_20)
	target_link_libraries(${target_name} PRIVATE {{tmplr.repo_name | lowercase }})
	set_target_properties(${target_name} PROPERTIES RUNTIME_OUTPUT_DIRECTORY "${${PROJECT_NAME}_EXE_DIR}/examples")
endforeach ()

end_section()
