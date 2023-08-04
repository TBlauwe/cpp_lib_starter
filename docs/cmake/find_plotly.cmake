macro(find_plotly)
    # Set the filepath and URL for the file to be downloaded
    set(PLOTLY_FILENAME "plotly-${CPM_PLOTLY_VERSION}.min.js")
    set(PLOTLY_PATH "${CPM_SOURCE_CACHE}")
    set(PLOTLY_FILEPATH "${PLOTLY_PATH}/${PLOTLY_FILENAME}")
    set(PLOTLY_URL "https://raw.githubusercontent.com/plotly/plotly.js/v${CPM_PLOTLY_VERSION}/dist/plotly.min.js")

	# Check if the file already exists in the specified location
	message(CHECK_START "Finding plotly [${CPM_PLOTLY_VERSION}] ")
	indent()
	if(NOT EXISTS ${PLOTLY_FILEPATH})

		message(STATUS "Not found in ${CPM_SOURCE_CACHE}.")
		message(STATUS "Downloading from '${PLOTLY_URL}' to '${PLOTLY_FILEPATH}'")

		file(DOWNLOAD ${PLOTY_URL} ${PLOTLY_FILEPATH}
			 STATUS status
		)

		# Log any errors of download
		list(GET ${status} 0 status_code)
		if(NOT status_code EQUAL 0)
		  list(GET ${status} 1 status_string)
		  message(FATAL_ERROR "Error: downloading '${PLOTLY_URL}' - ${status_string}")
		endif()

		# Message to indicate the successful download
		message(STATUS "Downloaded '${url}' to '${file_path}'")
	else()
		message(STATUS "Found in ${CPM_SOURCE_CACHE}.")

	endif()
	message(CHECK_PASS "done.")
endmacro()