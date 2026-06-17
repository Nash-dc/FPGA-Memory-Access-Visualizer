cmake_minimum_required(VERSION 3.20)
project(MemoryAccessPass LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)


set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fno-rtti -fno-exceptions -fPIC -fvisibility=hidden")

set(LLVM_DIR "/data/hls-dev/src/hls-llvm-project/hls-build/lib/cmake/llvm")
find_package(LLVM REQUIRED CONFIG)

add_definitions(${LLVM_DEFINITIONS})

set(MEMORY_ACCESS_PASS_SOURCES
    AnalysisDriver.cpp
    InterproceduralAnalysis.cpp
    IRUtils.cpp
    MemoryAnalysis.cpp
    MemoryAccessPass.cpp
    PragmaParser.cpp
    ReportPrinter.cpp
)

add_library(MemoryAccessPass MODULE ${MEMORY_ACCESS_PASS_SOURCES})

target_include_directories(MemoryAccessPass PRIVATE ${LLVM_INCLUDE_DIRS})

set_target_properties(MemoryAccessPass PROPERTIES
    LINK_FLAGS "-Wl,--allow-shlib-undefined"
)

add_library(TopLevelMemoryTracePass MODULE TopLevelMemoryTracePass.cpp)

target_include_directories(TopLevelMemoryTracePass PRIVATE ${LLVM_INCLUDE_DIRS})

set_target_properties(TopLevelMemoryTracePass PROPERTIES
    LINK_FLAGS "-Wl,--allow-shlib-undefined"
)
