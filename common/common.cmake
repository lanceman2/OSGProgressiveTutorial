# ref: https://cmake.org/cmake/help/v3.0/manual/cmake-commands.7.html
cmake_minimum_required(VERSION 2.6)
set(OSG_ROOT "/usr/local")
set(CMAKE_BUILD_WITH_INSTALL_RPATH TRUE)
set(CMAKE_INSTALL_RPATH "${OSG_ROOT}/lib64")

# get the name of the example from the example directory name
get_filename_component(DIR "${CMAKE_CURRENT_SOURCE_DIR}" NAME)
string(REGEX REPLACE "^[0-9][0-9]_" "" MOD "${DIR}")

project(${MOD})
add_executable(${MOD} ${MOD}.cpp)

include_directories("${OSG_ROOT}/include")
link_directories("${OSG_ROOT}/lib64")
target_link_libraries(${MOD} OpenThreads osg osgDB osgUtil osgViewer)
