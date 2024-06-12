# From : https://github.com/friendlyanon/cmake-init-shared-static/blob/master/cmake/variables.cmake

# ---- Suppress C4251 on Windows ----
set(pragma_suppress_c4251 "
/* This needs to suppress only for MSVC */
#if defined(_MSC_VER) && !defined(__ICL)
#  define SHARED_SUPPRESS_C4251 _Pragma(\"warning(suppress:4251)\")
#else
#  define SHARED_SUPPRESS_C4251
#endif
")


# ---- Warning guard ----
# target_include_directories with the SYSTEM modifier will request the compiler
# to omit warnings from the provided paths, if the compiler supports that
# This is to provide a user experience similar to find_package when
# add_subdirectory or FetchContent is used to consume this project
set(${PROJECT_NAME}_WARNING_GUARD "")
if(NOT PROJECT_IS_TOP_LEVEL)
  option(
      ${PROJECT_NAME}_INCLUDES_WITH_SYSTEM
      "Use SYSTEM modifier for shared's includes, disabling warnings"
      ON
  )
  mark_as_advanced(${PROJECT_NAME}_INCLUDES_WITH_SYSTEM)
  if(${PROJECT_NAME}_INCLUDES_WITH_SYSTEM)
    set(${PROJECT_NAME}_WARNING_GUARD SYSTEM)
  endif()
endif()
