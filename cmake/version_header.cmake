MESSAGE(STATUS "Configure version.hpp")
configure_file(${PROJECT_SOURCE_DIR}/src/version.hpp.in ${PROJECT_SOURCE_DIR}/include/${PROJECT_NAME}/version.hpp @ONLY)