# ----- CMake configuration 
cmake_minimum_required (VERSION 3.14...3.26)

# Enable Hot Reload for MSVC compilers if supported.
if (POLICY CMP0141)
  cmake_policy(SET CMP0141 NEW)
  set(CMAKE_MSVC_DEBUG_INFORMATION_FORMAT "$<IF:$<AND:$<C_COMPILER_ID:MSVC>,$<CXX_COMPILER_ID:MSVC>>,$<$<CONFIG:Debug,RelWithDebInfo>:EditAndContinue>,$<$<CONFIG:Debug,RelWithDebInfo>:ProgramDatabase>>")
endif()

# Convience variable so that executables (tests, benchmarks, experiments, examples) are outputed to a specific folder.
set(PROJECT_EXE_DIR "${CMAKE_BINARY_DIR}/bin/") 

# ----- Project information
project(MY_PROJECT
        VERSION 0.1.0
        DESCRIPTION "My desc"
        HOMEPAGE_URL "https://github.com"
        LANGUAGES C CXX
)


# ----- CMake libraries
# Dependencies are added via CPM.
# See https://github.com/cpm-cmake/CPM.cmake for more info.
set(CPM_DOWNLOAD_VERSION 0.38.2)
include(cmake/cpm.cmake)
include(cmake/target_set_compile_warnings.cmake)


# ----- Dependencies


# ----- Include guard
# Only do these if this is the main project, and not if it is included through add_subdirectory
if(CMAKE_PROJECT_NAME STREQUAL PROJECT_NAME)
   # Optionally set things like CMAKE_CXX_STANDARD, CMAKE_POSITION_INDEPENDENT_CODE here

  # Let's ensure -std=c++xx instead of -std=g++xx
  set(CMAKE_CXX_EXTENSIONS OFF)

  # Let's nicely support folders in IDEs
  set_property(GLOBAL PROPERTY USE_FOLDERS ON)
endif()


# ----- Main Target
SET(SOURCE_LIST
    "src/lib.cpp"
)

SET(HEADER_LIST
    "include/my_project/lib.hpp"
)

add_library (my_project ${SOURCE_LIST} ${HEADER_LIST})
target_include_directories(my_project PUBLIC include)
target_compile_features(my_project PRIVATE cxx_std_20)
target_compile_options(my_project PUBLIC $<$<CXX_COMPILER_ID:MSVC>:/Zc:preprocessor>) # if using __VA_OPT__, we enforce latest preprocessor on MSVC
target_compile_options(my_project PUBLIC $<$<COMPILE_LANG_AND_ID:CXX,MSVC>:/permissive->) # being a cross-platform target, we enforce standards conformance on MSVC
if(CMAKE_PROJECT_NAME STREQUAL PROJECT_NAME)
  target_set_compile_warnings_cxx(my_project)

  # Subdirectories only available if this is the main app
  include(CTest)
  add_subdirectory(tests)
  add_subdirectory(benchmarks)

  # Docs only available if this is the main app
  find_package(Doxygen)
  if(Doxygen_FOUND)
    add_subdirectory(docs)
  else()
    message(STATUS "Doxygen not found, skipping docs")
  endif()
endif()
