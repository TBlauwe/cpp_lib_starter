# ------------------------------------------------------------------------------ 
#           File : docs/CMakeList.txt
#         Author : TBlauwe
#    Description : CMake file to build docs using doxygen and m.css.
#
#                  Version of each dependency can be set through options :
#                  * CPM_M_CSS_VERSION
#
#                  CPM noteworthy options :
#                  * CPM_SOURCE_CACHE : download location.
#                  * CPM_USE_LOCAL_PACKAGES : search for locally installed dependencies first.
#                  * CPM_LOCAL_PACKAGES_ONLY : error if dependecy not found locally.
# ------------------------------------------------------------------------------ 
banner_2(CHECK_START "Configuring target : docs")


# ------------------------------------------------------------------------------
# --- OPTIONS
# ------------------------------------------------------------------------------
ADD_VERSION(NAME m.css VERSION "master")
PRINT_VERSIONS()


# ------------------------------------------------------------------------------
# --- Depedencies
# ------------------------------------------------------------------------------

# Doxygen is a documentation generator and static analysis tool for software source trees.
space()
message(CHECK_START "Finding Doxygen")
indent()
find_package(Doxygen)
outdent()
if(Doxygen_FOUND)
    message(CHECK_PASS "found.")
else()
    message(CHECK_FAIL "not found. Skipping docs.")
    list(APPEND missing_components "Doxygen")
endif()

# M.CSS is a no-nonsense, no-JavaScript CSS framework, site and documentation theme 
# for content-oriented websites
DOWNLOAD_LIBRARY(
        NAME m.css 
        GITHUB_REPOSITORY mosra/m.css
)


# ------------------------------------------------------------------------------
# --- Target : GenerateDocs and OpenDocs
# ------------------------------------------------------------------------------
if(missing_components)
    message(CHECK_FAIL "missing components: ${missing_components}")
else()
    message(CHECK_PASS "ALL COMPONENTS FOUND")

	set(DOXYGEN_PROJECT_NAME  "${PROJECT_NAME}")
	set(DOXYGEN_PROJECT_VERSION ${PROJECT_VERSION})
	set(DOXYGEN_PROJECT_ROOT "${PROJECT_SOURCE_DIR}/")
	set(DOXYGEN_OUTPUT_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/doxygen")

	configure_file(${CMAKE_CURRENT_LIST_DIR}/Doxyfile ${CMAKE_CURRENT_BINARY_DIR}/Doxyfile)
	configure_file(${CMAKE_CURRENT_LIST_DIR}/conf.py ${CMAKE_CURRENT_BINARY_DIR}/conf.py)

	add_custom_target(
	  GenerateDocs
	  ${CMAKE_COMMAND} -E make_directory "${DOXYGEN_OUTPUT_DIRECTORY}"
	  COMMAND python "${m.css_SOURCE_DIR}/documentation/doxygen.py" "${CMAKE_CURRENT_BINARY_DIR}/conf.py" --debug
	  COMMAND echo "Docs written to: ${DOXYGEN_OUTPUT_DIRECTORY}"
	  WORKING_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}"
	  SOURCES
		"conf.py"
		"Doxyfile"
		"pages/about.dox"
	)

	# Convenience target to open docs
	add_custom_target(
	  OpenDocs 
	  COMMAND "${DOXYGEN_OUTPUT_DIRECTORY}/html/index.html"
	  WORKING_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}"
	)
endif()