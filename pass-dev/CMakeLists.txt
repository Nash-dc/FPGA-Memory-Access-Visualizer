cmake_minimum_required(VERSION 3.20)
project(MemoryAccessPass LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)


set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fno-rtti -fno-exceptions -fPIC -fvisibility=hidden")

set(LLVM_DIR "/data/hls-dev/src/hls-llvm-project/hls-build/lib/cmake/llvm")
find_package(LLVM REQUIRED CONFIG)

include_directories(${LLVM_INCLUDE_DIRS})
add_definitions(${LLVM_DEFINITIONS})

add_library(MemoryAccessPass MODULE MemoryAccessPass.cpp)

set_target_properties(MemoryAccessPass PROPERTIES
    LINK_FLAGS "-Wl,--allow-shlib-undefined"
)
