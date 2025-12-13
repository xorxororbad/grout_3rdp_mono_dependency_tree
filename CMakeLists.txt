cmake_minimum_required(VERSION 4.1.2)
set(CMAKE_EXPERIMENTAL_CXX_IMPORT_STD "d0edc3af-4c50-42ea-a356-e2862fe7a444")

project(3rd_party LANGUAGES CXX 
                  VERSION 0.1.0
)

set(CMAKE_CXX_MODULE_STD 1)
set(CMAKE_CXX_STANDARD 26)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_EXPORT_COMPILE_COMMANDS yes)
set(CMAKE_BUILD_TYPE Debug)

list(PREPEND CMAKE_PREFIX_PATH "${CMAKE_CURRENT_SOURCE_DIR}/../../.deploy/")
set(EXT_INSTALL_PREFIX 
    "${CMAKE_CURRENT_SOURCE_DIR}/../../.deploy/"
    CACHE PATH "Default deployment directory prefix for the project." FORCE
)
set(CMAKE_INSTALL_BINDIR
    "./bin" 
    CACHE STRING "Default deployment directory for binaries." FORCE
)
set(CMAKE_INSTALL_LIBDIR
    "./lib" 
    CACHE STRING "Default deployment directory for libraries." FORCE
)
set(CMAKE_INSTALL_INCLUDEDIR
    "./include" 
    CACHE STRING "Default deployment directory for includes." FORCE
)

set(BENCHMARK_ENABLE_TESTING "OFF" CACHE STRING "Disble google benchmark tests.")

include(FetchContent)

include(${CMAKE_CURRENT_SOURCE_DIR}/mirrors/cmake/sqlite_build.cmake)

include(ExternalProject)

ExternalProject_Add(miniaudio
    SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/mirrors/miniaudio
    CMAKE_ARGS
        -DCMAKE_BUILD_TYPE=Release
        -DCMAKE_INSTALL_PREFIX=${EXT_INSTALL_PREFIX}
    BUILD_ALWAYS OFF
)

ExternalProject_Add(sdl
    SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/mirrors/sdl
    CMAKE_ARGS
        -DCMAKE_BUILD_TYPE=Release
        -DCMAKE_INSTALL_PREFIX=${EXT_INSTALL_PREFIX}
    BUILD_ALWAYS OFF
)

ExternalProject_Add(tracy
    SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/mirrors/tracy
    CMAKE_ARGS
        -DCMAKE_BUILD_TYPE=Release
        -DCMAKE_INSTALL_PREFIX=${EXT_INSTALL_PREFIX}
    BUILD_ALWAYS OFF
)

ExternalProject_Add(googletest
    SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/mirrors/googletest
    CMAKE_ARGS
        -DCMAKE_BUILD_TYPE=Release
        -DCMAKE_INSTALL_PREFIX=${EXT_INSTALL_PREFIX}
    BUILD_ALWAYS OFF
)

ExternalProject_Add(googlebenchmark
    SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/mirrors/googlebenchmark
    CMAKE_ARGS
        -DCMAKE_BUILD_TYPE=Release
        -DCMAKE_INSTALL_PREFIX=${EXT_INSTALL_PREFIX}
        -DBENCHMARK_ENABLE_GTEST_TESTS=OFF
        -DBENCHMARK_ENABLE_TESTING=OFF
    BUILD_ALWAYS OFF
)

ExternalProject_Add(grout_zstd
    SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/mirrors/zstd/build/cmake
    CMAKE_ARGS
        -DCMAKE_BUILD_TYPE=Release
        -DCMAKE_INSTALL_PREFIX=${EXT_INSTALL_PREFIX}
    BUILD_ALWAYS OFF
)

ExternalProject_Add(jsoncpp
    SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/mirrors/jsoncpp
    CMAKE_ARGS
        -DCMAKE_BUILD_TYPE=Release
        -DCMAKE_INSTALL_PREFIX=${EXT_INSTALL_PREFIX}
    BUILD_ALWAYS OFF
)

ExternalProject_Add(tracy_profiler
    SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/mirrors/tracy/profiler
    CMAKE_ARGS
        -DCMAKE_BUILD_TYPE=Release
        -DCMAKE_INSTALL_PREFIX=${EXT_INSTALL_PREFIX}
    BUILD_ALWAYS OFF
)

ExternalProject_Add(grout_boost
    SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/mirrors/boost/
    CMAKE_ARGS
        -DCMAKE_BUILD_TYPE=Release
        -DCMAKE_INSTALL_PREFIX=${EXT_INSTALL_PREFIX}
        -DCMAKE_MODULE_PATH=${CMAKE_CURRENT_SOURCE_DIR}/mirrors/boost/tools/cmake/include/ ${CMAKE_MODULE_PATH}
        -DBOOST_BUILD_FILESYSTEM=ON
        -DBoost_VERBOSE=1
        -DBOOST_ENABLE_PYTHON=ON
    BUILD_ALWAYS OFF
)

set(BOTAN_PREFIX ${CMAKE_BINARY_DIR}/botan)
set(BOTAN_INSTALL ${BOTAN_PREFIX}/install)

ExternalProject_Add(botan
    SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/mirrors/botan/
    CONFIGURE_COMMAND ${Python3_EXECUTABLE} ${CMAKE_CURRENT_SOURCE_DIR}/mirrors/botan/configure.py
                             --prefix=${BOTAN_INSTALL}
                             --build-targets=static
                             --disable-shared
                             --with-debug-info
    BUILD_COMMAND make
    INSTALL_COMMAND make install
    BUILD_ALWAYS OFF
)

