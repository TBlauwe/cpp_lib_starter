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
section(CHECK_START "Documentation")


# ------------------------------------------------------------------------------
# --- OPTIONS
# ------------------------------------------------------------------------------
ADD_VERSION(NAME MCSS VERSION "master")


# ------------------------------------------------------------------------------
# --- Depedencies
# ------------------------------------------------------------------------------

# Doxygen is a documentation generator and static analysis tool for software source trees.
find_library(Doxygen)
if(NOT Doxygen_FOUND)
    message(STATUS "Skipping docs.")
	return()
endif()

space()

# M.CSS is a no-nonsense, no-JavaScript CSS framework, site and documentation theme 
# for content-oriented websites
DOWNLOAD_LIBRARY(
        NAME MCSS
        GITHUB_REPOSITORY mosra/m.css
)
if(NOT MCSS_ADDED)
    message(STATUS "Skipping docs.")
	return()
endif()


# ------------------------------------------------------------------------------
# --- Target : my_lib_docs & my_lib_open_docs
# ------------------------------------------------------------------------------
set(DOXYGEN_PROJECT_NAME  "${PROJECT_NAME}")
set(DOXYGEN_PROJECT_VERSION ${PROJECT_VERSION})
set(DOXYGEN_PROJECT_ROOT "${PROJECT_SOURCE_DIR}/")
set(DOXYGEN_OUTPUT_DIR "${CMAKE_CURRENT_BINARY_DIR}/doxygen")

configure_file(${CMAKE_CURRENT_LIST_DIR}/Doxyfile ${CMAKE_CURRENT_BINARY_DIR}/Doxyfile)
configure_file(${CMAKE_CURRENT_LIST_DIR}/conf.py ${CMAKE_CURRENT_BINARY_DIR}/conf.py)

file(GLOB_RECURSE pages "pages/*.md")
file(GLOB_RECURSE images "images/*.png")

add_custom_target(
	docs
	${CMAKE_COMMAND} -E make_directory "${DOXYGEN_OUTPUT_DIR}"
	COMMAND python "${MCSS_SOURCE_DIR}/documentation/doxygen.py" "${CMAKE_CURRENT_BINARY_DIR}/conf.py" --debug
	COMMAND echo "Docs written to: ${DOXYGEN_OUTPUT_DIR}"
	WORKING_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}"
	SOURCES
		"conf.py"
		"Doxyfile"
		${pages}
		${images}
)

# Utility target to open docs
add_custom_target(
	open_docs
	COMMAND "${DOXYGEN_OUTPUT_DIR}/html/index.html"
)

end_section(
	CONDITION TARGET generate_docs
	PASS "done."
	FAIL "failed."
)