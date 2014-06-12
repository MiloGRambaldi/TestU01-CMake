set( ERROR_MESSAGE "Cannot find the TestU01 installation. Please set TESTU01_ROOT to the root directory containing TESTU01." )
mark_as_advanced( TESTU01_ROOT_DIR )
if( TESTU01_ROOT_DIR STREQUAL TESTU01_ROOT_DIR-NOTFOUND )
	message( SEND_ERROR ${ERROR_MESSAGE} )
else()
	set( TESTU01_FOUND TRUE )
endif()

set( TESTU01_INCLUDE_DIRS ${TESTU01_ROOT_DIR}/include )
set( TESTU01_LIBRARY_DIRS ${TESTU01_ROOT_DIR}/lib )

