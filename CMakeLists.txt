# SPDX-License-Identifier: BSD-3-Clause

cmake_minimum_required(VERSION 3.15)
cmake_policy(VERSION 3.15)

#project(ofm)
#set(PYSRC ${CMAKE_CURRENT_SOURCE_DIR})
set(RPM_PYTHON_DEP_LIST pyyaml matplotlib pillow tabulate colorama)


project(seaborn)
set(PYSRC_VERSION 0.13.2)
set(PYSRC "${PROJECT_NAME}==${PYSRC_VERSION}")
set(RPM_PYTHON_DEP_LIST matplotlib numpy pandas)
set(PACKAGE_VERSION "${GIT_VERSION}")

include(${CMAKE_CURRENT_LIST_DIR}/python.cmake)
