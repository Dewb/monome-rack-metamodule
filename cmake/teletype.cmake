set(TELETYPE teletype5)

file(GLOB TELETYPE_FIRMWARE_SRCS CONFIGURE_DEPENDS 
    ${FIRMWARE_DIR}/${TELETYPE}/src/*.c
    ${FIRMWARE_DIR}/${TELETYPE}/src/scanner.c
    ${FIRMWARE_DIR}/${TELETYPE}/src/match_token.c
    ${FIRMWARE_DIR}/${TELETYPE}/module/gitversion.c
    ${FIRMWARE_DIR}/${TELETYPE}/src/ops/*.c
    ${FIRMWARE_DIR}/${TELETYPE}/module/*.c
	${FIRMWARE_DIR}/${TELETYPE}/libavr32/src/events.c
	${FIRMWARE_DIR}/${TELETYPE}/libavr32/src/timers.c
	${FIRMWARE_DIR}/${TELETYPE}/libavr32/src/util.c
	${FIRMWARE_DIR}/${TELETYPE}/libavr32/src/font.c
	${FIRMWARE_DIR}/${TELETYPE}/libavr32/src/kbd.c
	${FIRMWARE_DIR}/${TELETYPE}/libavr32/src/region.c
	${FIRMWARE_DIR}/${TELETYPE}/libavr32/src/random.c
	${FIRMWARE_DIR}/${TELETYPE}/libavr32/src/usb/hid/hid.c
	${FIRMWARE_DIR}/${TELETYPE}/libavr32/src/music.c
	${FIRMWARE_DIR}/${TELETYPE}/libavr32/src/midi_common.c
	${FIRMWARE_DIR}/${TELETYPE}/libavr32/src/euclidean/*.c
	${FIRMWARE_DIR}/mock_hardware/*.c
	${FIRMWARE_DIR}/mock_hardware/common/*.c
	${FIRMWARE_DIR}/mock_hardware/modules/teletype/*.c
)

list(REMOVE_ITEM TELETYPE_FIRMWARE_SRCS ${FIRMWARE_DIR}/${TELETYPE}/module/usb_disk_mode.c)

list(APPEND TELETYPE_FIRMWARE_INCLUDES 
	${FIRMWARE_DIR}/${TELETYPE}/libavr32/src
	${FIRMWARE_DIR}/${TELETYPE}/libavr32/src/usb/midi
	${FIRMWARE_DIR}/${TELETYPE}/libavr32/src/usb/hid
	${FIRMWARE_DIR}/${TELETYPE}/libavr32/src/usb/cdc
	${FIRMWARE_DIR}/${TELETYPE}/libavr32/src/usb/ftdi
	${FIRMWARE_DIR}/${TELETYPE}/libavr32/conf
	${FIRMWARE_DIR}/${TELETYPE}/libavr32/conf/teletype
	${FIRMWARE_DIR}/${TELETYPE}/libavr32/asf/common/services/usb
	${FIRMWARE_DIR}/${TELETYPE}/libavr32/asf/common/services/usb/uhc
	${FIRMWARE_DIR}/${TELETYPE}/libavr32/asf/common/services/usb/class/hid
	${FIRMWARE_DIR}/${TELETYPE}
	${FIRMWARE_DIR}/${TELETYPE}/src
	${FIRMWARE_DIR}/${TELETYPE}/src/ops
)

list(APPEND FIRMWARE_SRCS ${TELETYPE_FIRMWARE_SRCS})
list(APPEND FIRMWARE_INCLUDES ${TELETYPE_FIRMWARE_INCLUDES})

target_compile_definitions(MonomeMM
    PRIVATE __AVR32_UC3B0512__
)

set_property(
    SOURCE ${FIRMWARE_DIR}/${TELETYPE}/module/main.c
    PROPERTY COMPILE_DEFINITIONS
    main=main_teletype
)

execute_process(
    WORKING_DIRECTORY ${FIRMWARE_DIR}/${TELETYPE}
    COMMAND /bin/sh ${CMAKE_CURRENT_LIST_DIR}/teletype-codegen.sh
)
