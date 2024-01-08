# From : https://github.com/friendlyanon/cmake-init-shared-static/blob/master/cmake/prelude.cmake

if(CMAKE_SOURCE_DIR STREQUAL CMAKE_BINARY_DIR)
  message(
      FATAL_ERROR
      "In-source builds are not supported. "
      "The README provides more information on how build this project. "
      "You may need to delete 'CMakeCache.txt' and 'CMakeFiles/' first."
  )
endif()