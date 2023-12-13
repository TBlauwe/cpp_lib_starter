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
# --- Dependencies
# ------------------------------------------------------------------------------

# Doxygen is a documentation generator and static analysis tool for software source trees.
find_library(Doxygen)
if(NOT Doxygen_FOUND)
    message(STATUS "Skipping docs.")
	return()
endif()

space()

# Doxygen awesome CSS is a custom CSS theme for doxygen html-documentation with lots of customization parameters.
use_version(NAME DOXYGEN_AWESOME_CSS VERSION "v2.3.1")
download_library(
        NAME DOXYGEN_AWESOME_CSS
        GITHUB_REPOSITORY jothepro/doxygen-awesome-css
)
if(NOT DOXYGEN_AWESOME_CSS_ADDED)
    message(STATUS "Skipping docs.")
	return()
endif()

use_version(NAME PLOTLY VERSION "2.25.1")


# ------------------------------------------------------------------------------
# --- Target : my_lib_docs & my_lib_open_docs
# ------------------------------------------------------------------------------
set(DOXYGEN_OUTPUT_DIR "${CMAKE_CURRENT_BINARY_DIR}/doxygen")
set(DOXYGEN_HTML_DIR "${DOXYGEN_OUTPUT_DIR}/html")
set(DOXYGEN_PAGES_DIR "${PROJECT_SOURCE_DIR}/docs/pages")
set(DOXYGEN_IMAGES_DIR "${PROJECT_SOURCE_DIR}/docs/images")
set(PROJECT_LOGO "${PROJECT_SOURCE_DIR}/docs/logo/project_logo_55x55.png")

configure_file(config/Doxyfile.in ${CMAKE_CURRENT_BINARY_DIR}/Doxyfile)
configure_file(config/conf.py ${CMAKE_CURRENT_BINARY_DIR}/conf.py)
configure_file(resources/header.html ${CMAKE_CURRENT_BINARY_DIR}/header.html)

file(GLOB_RECURSE DOCS_PAGES "pages/*.md")
file(GLOB_RECURSE DOCS_IMAGES "images/*")

set(DOCS_CONFIG_FILES 
	"config/conf.py"
	"config/Doxyfile.in"
)
set(DOCS_RESOURCE_FILES 
	"resources/cppreference-doxygen-web.tag"
	"resources/header.html"
	"resources/custom.css"
)

add_custom_target(
	docs
	COMMAND ${CMAKE_COMMAND} -E make_directory "${DOXYGEN_OUTPUT_DIR}"
	COMMAND ${CMAKE_COMMAND} -E make_directory "${DOXYGEN_HTML_DIR}"
	COMMAND ${CMAKE_COMMAND} -E copy "${PROJECT_SOURCE_DIR}/docs/vendor/plotly-${CPM_PLOTLY_VERSION}.min.js" "${DOXYGEN_HTML_DIR}"
	COMMAND ${CMAKE_COMMAND} -E copy_directory "${PROJECT_SOURCE_DIR}/docs/images" "${DOXYGEN_HTML_DIR}"
	COMMAND ${DOXYGEN_EXECUTABLE} ${DOXYGEN_OUT}
	COMMAND echo "Docs written to: ${DOXYGEN_OUTPUT_DIR}"
	WORKING_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}"
	SOURCES
		${DOCS_CONFIG_FILES}
		${DOCS_RESOURCE_FILES}
		${DOCS_PAGES}
		${DOCS_IMAGES}
)


# Utility target to open docs
add_custom_target(
	open_docs
	COMMAND "${DOXYGEN_OUTPUT_DIR}/html/index.html"
)

end_section(
	CONDITION TARGET docs
	PASS "done."
	FAIL "failed."
)