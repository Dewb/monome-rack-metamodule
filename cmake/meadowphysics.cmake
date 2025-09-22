file(GLOB MEADOWPHYSICS_FIRMWARE_SRCS CONFIGURE_DEPENDS 
    ${FIRMWARE_DIR}/meadowphysics/src/main.c
    ${FIRMWARE_DIR}/meadowphysics/libavr32/src/events.c
	${FIRMWARE_DIR}/meadowphysics/libavr32/src/timers.c
	${FIRMWARE_DIR}/meadowphysics/libavr32/src/util.c
	${FIRMWARE_DIR}/mock_hardware/*.c
	${FIRMWARE_DIR}/mock_hardware/common/*.c
	${FIRMWARE_DIR}/mock_hardware/modules/trilogy/*.c
)

list(APPEND MEADOWPHYSICS_FIRMWARE_INCLUDES 
    ${FIRMWARE_DIR}/mock_hardware
    ${FIRMWARE_DIR}/mock_hardware/include
    ${FIRMWARE_DIR}/mock_hardware/include/avr32
	${FIRMWARE_DIR}/meadowphysics/libavr32/src
	${FIRMWARE_DIR}/meadowphysics/libavr32/src/usb/midi
	${FIRMWARE_DIR}/meadowphysics/libavr32/src/usb/hid
	${FIRMWARE_DIR}/meadowphysics/libavr32/src/usb/cdc
	${FIRMWARE_DIR}/meadowphysics/libavr32/asf/common/services/usb
	${FIRMWARE_DIR}/meadowphysics/libavr32/asf/common/services/usb/uhc
	${FIRMWARE_DIR}/meadowphysics/libavr32/conf
	${FIRMWARE_DIR}/meadowphysics/libavr32/conf/trilogy
)

list(APPEND FIRMWARE_SRCS ${MEADOWPHYSICS_FIRMWARE_SRCS})
list(APPEND FIRMWARE_INCLUDES ${MEADOWPHYSICS_FIRMWARE_INCLUDES})

target_compile_definitions(MonomeMM
    PRIVATE __AVR32_UC3B0256__
)

set_property(
    SOURCE ${FIRMWARE_DIR}/meadowphysics/src/main.c
    PROPERTY COMPILE_DEFINITIONS
    main=main_meadowphysics
)