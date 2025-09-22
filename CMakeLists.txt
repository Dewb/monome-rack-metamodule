cmake_minimum_required(VERSION 3.22)

if(NOT "${METAMODULE_SDK_DIR}" STREQUAL "")
	message("METAMODULE_SDK_DIR set by CMake variable ${METAMODULE_SDK_DIR}")
elseif (DEFINED ENV{METAMODULE_SDK_DIR})
	set(METAMODULE_SDK_DIR "$ENV{METAMODULE_SDK_DIR}")
	message("METAMODULE_SDK_DIR set by environment variable ${METAMODULE_SDK_DIR}")
else()
	set(METAMODULE_SDK_DIR "${CMAKE_CURRENT_LIST_DIR}/../metamodule-plugin-sdk")
	message("METAMODULE_SDK_DIR set to default: ${METAMODULE_SDK_DIR}")
endif()

if(DEFINED ENV{METAMODULE_PLUGIN_CPP})
    set(METAMODULE_PLUGIN_CPP "$ENV{METAMODULE_PLUGIN_CPP}")
else()
    set(METAMODULE_PLUGIN_CPP "plugin-firmware.cpp")
endif()

include(${METAMODULE_SDK_DIR}/plugin.cmake)

project(MonomeMetaModulePlugin 
    VERSION     0.1 
    DESCRIPTION "monome-rack for MetaModule"
    LANGUAGES   C CXX ASM
)

add_library(MonomeMM STATIC)

# Add sources from the monome-rack source repo
set(SOURCE_DIR ${CMAKE_CURRENT_LIST_DIR}/monome-rack)
set(FIRMWARE_DIR ${SOURCE_DIR}/firmware)

file(GLOB COMMON_SRCS CONFIGURE_DEPENDS 
    "${SOURCE_DIR}/src/common/core/*.cpp" 
    "${SOURCE_DIR}/src/common/core/GridConnection/GridConnection.cpp"
    "${SOURCE_DIR}/src/common/core/GridConnection/GridConsumerBase.cpp"
    "${SOURCE_DIR}/src/virtualgrid/*.cpp"
    "${SOURCE_DIR}/lib/base64/*.cpp"
)
file(GLOB_RECURSE TELETYPE_SRCS CONFIGURE_DEPENDS "${SOURCE_DIR}/src/teletype/*.cpp")
file(GLOB_RECURSE ANSIBLE_SRCS CONFIGURE_DEPENDS "${SOURCE_DIR}/src/ansible/*.cpp")
file(GLOB_RECURSE MEADOWPHYSICS_SRCS CONFIGURE_DEPENDS "${SOURCE_DIR}/src/meadowphysics/*.cpp")
file(GLOB_RECURSE EARTHSEA_SRCS CONFIGURE_DEPENDS "${SOURCE_DIR}/src/earthsea/*.cpp")
file(GLOB_RECURSE WHITEWHALE_SRCS CONFIGURE_DEPENDS "${SOURCE_DIR}/src/whitewhale/*.cpp")

set(FIRMWARE_SRCS )
set(FIRMWARE_INCLUDES )

include(${CMAKE_CURRENT_LIST_DIR}/cmake/meadowphysics.cmake)

target_sources(MonomeMM PRIVATE
    "plugin-impl.cpp"
    ${METAMODULE_PLUGIN_CPP}
    ${COMMON_SRCS}
    ${TELETYPE_SRCS}
    ${ANSIBLE_SRCS}
    ${EARTHSEA_SRCS}
    ${MEADOWPHYSICS_SRCS}
    ${WHITEWHALE_SRCS}
    ${FIRMWARE_SRCS}
)

# Add includes and compile options for source repo
target_include_directories(MonomeMM PRIVATE 
	${SOURCE_DIR}/src
	${SOURCE_DIR}/src/common
	${SOURCE_DIR}/src/common/core
	${SOURCE_DIR}/src/common/util
	${SOURCE_DIR}/src/common/widgets
	${SOURCE_DIR}/src/common/core/GridConnection
	${SOURCE_DIR}/src/whitewhale
	${SOURCE_DIR}/src/meadowphysics
	${SOURCE_DIR}/src/earthsea
	${SOURCE_DIR}/src/teletype
	${SOURCE_DIR}/src/ansible
	${SOURCE_DIR}/src/virtualgrid
    ${SOURCE_DIR}/lib
	${SOURCE_DIR}/lib/cbbq
	${SOURCE_DIR}/lib/base64
    ${SOURCE_DIR}/lib/serialosc
	${FIRMWARE_INCLUDES}
)

# Call this to link and create the plugin file
create_plugin(
    SOURCE_LIB      MonomeMM                                        # The cmake target name (defined in add_target)
    PLUGIN_NAME     monome                                          # This must match the brand "slug" used in VCV Rack
    PLUGIN_JSON     ${SOURCE_DIR}/plugin.json                       # Path to the plugin.json file used by VCV Rack
    SOURCE_ASSETS   ${CMAKE_CURRENT_LIST_DIR}/assets                # Path to the assets/ dir containing the PNGs
    DESTINATION     ${CMAKE_CURRENT_LIST_DIR}/metamodule-plugins    # Path to where you want the plugin file output
)

set (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} --save-temps")
set (CMAKE_C_FLAGS "${CMAKE_C_FLAGS} --save-temps")