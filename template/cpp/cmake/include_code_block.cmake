# Function to include a file inside a code block, which is probably in a markdown file.
# The extension is used to determine the code block language.
#
# Usage : 
# <!--BEGIN_INCLUDE="path/to/file.cpp"-->
# Everything between this two balises will be replaced by the content of the file inside a code block.
# <!--END_INCLUDE-->
function(include_code_block FILENAME)
	file(READ ${FILENAME} INPUT_CONTENT)
	if(INPUT_CONTENT)
		MESSAGE(STATUS "Looking for new code-blocks in ${FILENAME} ...")
		string(REGEX MATCHALL "(<!--BEGIN_INCLUDE=\"(.+\/[^\/]+)\"-->)(.*)(<!--END_INCLUDE-->)" matches ${INPUT_CONTENT})

		set(NEED_UPDATE FALSE)
		foreach(match ${matches})
			string(REGEX REPLACE "(<!--BEGIN_INCLUDE=\"(.+\/[^\/]+)\"-->)(.*)(<!--END_INCLUDE-->)" "\\1;\\2;\\3;\\4" groups ${match})
			list(GET groups 0 HEADER)
			list(GET groups 1 FILE_PATH)
			list(GET groups 2 BODY)
			list(GET groups 3 FOOTER)
			get_filename_component(FILEPATH_EXT ${FILE_PATH} EXT)
			string(REPLACE "." "" FILEPATH_EXT ${FILEPATH_EXT})

			file(READ "${PROJECT_SOURCE_DIR}/${FILE_PATH}" NEW_BODY)
			set(NEW_BODY "```${FILEPATH_EXT}\n${NEW_BODY}\n```")
			if(NOT "${NEW_BODY}" STREQUAL "${BODY}")
				string(REPLACE "${HEADER}${BODY}${FOOTER}" "${HEADER}\n${NEW_BODY}\n${FOOTER}" INPUT_CONTENT ${INPUT_CONTENT})
				set(NEED_UPDATE TRUE)
			endif()
		endforeach()

		if(NEED_UPDATE)
			file(WRITE ${FILENAME} ${INPUT_CONTENT})
			MESSAGE(STATUS "Looking for new code-blocks in ${FILENAME} ... DONE")
		else()
			MESSAGE(STATUS "Looking for new code-blocks in ${FILENAME} ... NONE")
		endif()
	endif()
endfunction()