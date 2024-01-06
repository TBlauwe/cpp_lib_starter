# This file is a cmake script so we can update each file that needs to include a file inside a code block.
# For example, we use this so we can update our README.me, to include an example cpp file.
# ---
# This script is called only when building documentation.
cmake_minimum_required(VERSION 3.17)

include(${PROJECT_SOURCE_DIR}/cmake/include_code_block.cmake)

INCLUDE_CODE_BLOCK("${PROJECT_SOURCE_DIR}/README.md")
# ---> You can add other files here <---
