# SPDX-License-Identifier: BSD-3-Clause
# ndk-sw tools-debug CMake build file
#
# Copyright (c) 2022 CESNET
#
# Author(s):
#   Martin Spinler <spinler@cesnet.cz
#
cmake_minimum_required(VERSION 3.15)
cmake_policy(VERSION 3.15)


set(PY_VER 3.9) # Can be set to 3.11, if the dependencies exists
set(PYPROJ_NAME python${PY_VER}-${PROJECT_NAME})

project(${PYPROJ_NAME} LANGUAGES C)

set(CPACK_GENERATOR   "RPM")
set(CMAKE_INSTALL_PREFIX "/")
set(CPACK_PACKAGING_INSTALL_PREFIX "/")


set(Python_FIND_UNVERSIONED_NAMES FIRST)
set(Python_FIND_UNVERSIONED_NAMES LAST)
#find_package(Python COMPONENTS Interpreter)
find_package(Python ${PY_VER} EXACT COMPONENTS Interpreter)

set(RPM_PYDEP_LIST ${RPM_PYTHON_DEP_LIST})
list(TRANSFORM RPM_PYDEP_LIST PREPEND "python${PY_VER}-")
set(RPM_PYSUG_LIST
	python${PY_VER}-nfb
)

string(JOIN " " CPACK_RPM_PACKAGE_REQUIRES ${RPM_PYDEP_LIST})
string(JOIN " " CPACK_RPM_PACKAGE_SUGGESTS ${RPM_PYSUG_LIST})

set(CMAKE_USE_RELATIVE_PATHS TRUE)

include(CPack)

set(SETUP_DEPS      "${CMAKE_CURRENT_SOURCE_DIR}/python.cmake")
set(SETUP_OUTPUT    "${CMAKE_CURRENT_BINARY_DIR}/build-python")

add_custom_command(
    OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/setup_timestamp
	COMMAND ${Python_EXECUTABLE} ARGS -m pip install --upgrade pip
	COMMAND ${Python_EXECUTABLE} ARGS -m pip install --no-deps --no-warn-script-location --root ${SETUP_OUTPUT} ${PYSRC}
    COMMAND ${CMAKE_COMMAND} -E touch ${CMAKE_CURRENT_BINARY_DIR}/setup_timestamp
    DEPENDS ${SETUP_DEPS}
)

add_custom_target(${PYPROJ_NAME} ALL DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/setup_timestamp)

install(
    DIRECTORY ${SETUP_OUTPUT}/
#    #DESTINATION "/" # FIXME may cause issues with other cpack generators
	DESTINATION "." #${CMAKE_CURRENT_BINARY_DIR}
    COMPONENT python
#	USE_SOURCE_PERMISSIONS
)
