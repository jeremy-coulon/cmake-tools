#=============================================================================
# Copyright (C) 2013 Jeremy Coulon <jeremy.coulon@free.fr>
#
# Distributed under the Boost Software License, Version 1.0.
# See accompanying file LICENSE_1_0.txt or copy at
#   http://www.boost.org/LICENSE_1_0.txt
#=============================================================================

if(CMAKE_COMPILER_IS_GNUCC)
    set(CMAKE_C_FLAGS_INIT                "-Wall --std=c11")
    set(CMAKE_C_FLAGS_RELWITHDEBINFO_INIT "-O3 -DNDEBUG -g")
    set(CMAKE_C_FLAGS_COVERAGE_INIT       "-O0 --coverage")
endif()

if(CMAKE_COMPILER_IS_GNUCXX)
    set(CMAKE_CXX_FLAGS_INIT                "-Wall --std=c++14")
    set(CMAKE_CXX_FLAGS_RELWITHDEBINFO_INIT "-O3 -DNDEBUG -g")
    set(CMAKE_CXX_FLAGS_COVERAGE_INIT       "-O0 --coverage")
endif()

if(CMAKE_COMPILER_IS_GNUCC OR CMAKE_COMPILER_IS_GNUCXX)
    # Set DT_RUNPATH instead of DT_RPATH
    # It allows the user to override rpath at runtime
    # by environment variable LD_LIBRARY_PATH
    set(CMAKE_EXE_LINKER_FLAGS_INIT    "-Wl,--enable-new-dtags")
    set(CMAKE_SHARED_LINKER_FLAGS_INIT "-Wl,--enable-new-dtags")

    # Linker flags used for coverage builds
    set(CMAKE_EXE_LINKER_FLAGS_COVERAGE_INIT    "--coverage")
    set(CMAKE_MODULE_LINKER_FLAGS_COVERAGE_INIT "")
    set(CMAKE_SHARED_LINKER_FLAGS_COVERAGE_INIT "--coverage")
    set(CMAKE_STATIC_LINKER_FLAGS_COVERAGE_INIT "")
endif()

if(CMAKE_C_COMPILER_LOADED)
    set(CMAKE_C_FLAGS_COVERAGE             "${CMAKE_C_FLAGS_COVERAGE_INIT}"             CACHE STRING "Flags used by the compiler during coverage builds.")
endif()
if(CMAKE_CXX_COMPILER_LOADED)
    set(CMAKE_CXX_FLAGS_COVERAGE           "${CMAKE_CXX_FLAGS_COVERAGE_INIT}"           CACHE STRING "Flags used by the compiler during coverage builds.")
endif()
if(CMAKE_C_COMPILER_LOADED OR CMAKE_CXX_COMPILER_LOADED)
    set(CMAKE_EXE_LINKER_FLAGS_COVERAGE    "${CMAKE_EXE_LINKER_FLAGS_COVERAGE_INIT}"    CACHE STRING "Flags used by the linker during coverage builds.")
    set(CMAKE_MODULE_LINKER_FLAGS_COVERAGE "${CMAKE_MODULE_LINKER_FLAGS_COVERAGE_INIT}" CACHE STRING "Flags used by the linker during coverage builds.")
    set(CMAKE_SHARED_LINKER_FLAGS_COVERAGE "${CMAKE_SHARED_LINKER_FLAGS_COVERAGE_INIT}" CACHE STRING "Flags used by the linker during coverage builds.")
    set(CMAKE_STATIC_LINKER_FLAGS_COVERAGE "${CMAKE_STATIC_LINKER_FLAGS_COVERAGE_INIT}" CACHE STRING "Flags used by the linker during coverage builds.")
    mark_as_advanced(
        CMAKE_C_FLAGS_COVERAGE
        CMAKE_CXX_FLAGS_COVERAGE
        CMAKE_EXE_LINKER_FLAGS_COVERAGE
        CMAKE_MODULE_LINKER_FLAGS_COVERAGE
        CMAKE_SHARED_LINKER_FLAGS_COVERAGE
        CMAKE_STATIC_LINKER_FLAGS_COVERAGE
    )
endif()

if((NOT DEFINED CMAKE_BUILD_TYPE) OR (CMAKE_BUILD_TYPE STREQUAL ""))
    # CMake defaults to leaving CMAKE_BUILD_TYPE empty. This screws up
    # differentiation between debug and release builds.
    set(CMAKE_BUILD_TYPE "RelWithDebInfo"
        CACHE STRING "Choose the type of build, options are: Debug Release RelWithDebInfo MinSizeRel Coverage."
        FORCE
    )
    mark_as_advanced(CMAKE_BUILD_TYPE)
endif()

if(CMAKE_CONFIGURATION_TYPES)
    list(APPEND CMAKE_CONFIGURATION_TYPES Coverage)
    list(REMOVE_DUPLICATES CMAKE_CONFIGURATION_TYPES)
    set(CMAKE_CONFIGURATION_TYPES "${CMAKE_CONFIGURATION_TYPES}"
        CACHE STRING "Choose the type of build, options are: Debug Release RelWithDebInfo MinSizeRel Coverage."
        FORCE
    )
    mark_as_advanced(CMAKE_CONFIGURATION_TYPES)
endif()
