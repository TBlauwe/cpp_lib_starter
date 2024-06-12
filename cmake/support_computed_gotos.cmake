# Computed gotos are supported by Clang and GCC, but not MSVC

if (CMAKE_CXX_COMPILER_ID STREQUAL "Clang")                      # using Clang
    #if (CMAKE_CXX_COMPILER_FRONTEND_VARIANT STREQUAL "MSVC")    # using clang with clang-cl front end
    #elseif (CMAKE_CXX_COMPILER_FRONTEND_VARIANT STREQUAL "GNU") # using clang with regular front end
    #endif()
    set(${PROJECT_NAME}_HAVE_COMPUTED_GOTOS TRUE)
elseif (CMAKE_CXX_COMPILER_ID STREQUAL "GNU")                    # using GCC
    set(${PROJECT_NAME}_HAVE_COMPUTED_GOTOS TRUE)
#elseif (CMAKE_CXX_COMPILER_ID STREQUAL "Intel")                 # using Intel C++
elseif (CMAKE_CXX_COMPILER_ID STREQUAL "MSVC")                   # using Visual Studio C++
    set(${PROJECT_NAME}_HAVE_COMPUTED_GOTOS False)
endif()