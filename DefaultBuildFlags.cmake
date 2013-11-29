#=============================================================================
# Copyright (C) 2013 Jeremy Coulon <jeremy.coulon@free.fr>
#
# Distributed under the Boost Software License, Version 1.0.
# See accompanying file LICENSE_1_0.txt or copy at
#   http://www.boost.org/LICENSE_1_0.txt
#=============================================================================

if(CMAKE_COMPILER_IS_GNUCC)
    set(CMAKE_C_FLAGS_INIT "-Wall")
    set(CMAKE_C_FLAGS_RELWITHDEBINFO_INIT "-O3 -DNDEBUG -g")
endif()

if(CMAKE_COMPILER_IS_GNUCXX)
    set(CMAKE_CXX_FLAGS_INIT "-Wall")
    set(CMAKE_CXX_FLAGS_RELWITHDEBINFO_INIT "-O3 -DNDEBUG -g")
endif()

if(CMAKE_COMPILER_IS_GNUCC OR CMAKE_COMPILER_IS_GNUCXX)
    # Set DT_RUNPATH instead of DT_RPATH
    # It allows the user to override rpath at runtime
    # by environment variable LD_LIBRARY_PATH
    set(CMAKE_EXE_LINKER_FLAGS_INIT "-Wl,--enable-new-dtags")
    set(CMAKE_SHARED_LINKER_FLAGS_INIT "-Wl,--enable-new-dtags")
endif()

if((NOT DEFINED CMAKE_BUILD_TYPE) OR (CMAKE_BUILD_TYPE STREQUAL ""))
    # CMake defaults to leaving CMAKE_BUILD_TYPE empty. This screws up
    # differentiation between debug and release builds.
    set(CMAKE_BUILD_TYPE "RelWithDebInfo" CACHE STRING "Choose the type of build, options are: None (CMAKE_CXX_FLAGS or CMAKE_C_FLAGS used) Debug Release RelWithDebInfo MinSizeRel." FORCE)
    mark_as_advanced(CMAKE_BUILD_TYPE)
endif()
