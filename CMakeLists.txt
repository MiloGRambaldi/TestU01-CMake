#############################################################################
# CMake Build System for TestU01                                            #
#																			#
# Copyright (C) 2014 James Hirschorn <James.Hirschorn@gmail.com>			#
#############################################################################

cmake_minimum_required ( VERSION 2.8 )

project( TestU01 )
set_property( GLOBAL PROPERTY USE_FOLDERS ON )

set( TestU01_MAJOR_VERSION 1 CACHE STRING "TestU01 major version number." FORCE )
set( TestU01_MINOR_VERSION 2.3 CACHE STRING "TestU01 minor version number." FORCE )
set( TestU01_VERSION_STRING "${TestU01_MAJOR_VERSION}.${TestU01_MINOR_VERSION}" )

#--------------------------------------------------
# initial settings - cached

OPTION ( TestU01_BUILD_STATIC "Build a static library." ON )
OPTION ( TestU01_BUILD_SHARED "Build a shared library." OFF )

#--------------------------------------------------
# initial settings - non-cached

set( TestU01_ROOT_DIR  ${PROJECT_SOURCE_DIR} )
# resolve the path without any relative components
get_filename_component( tmp ${TestU01_ROOT_DIR} REALPATH )
set( TestU01_ROOT_DIR  ${tmp} ) 

set( TestU01_TESTU01_DIR   ${TestU01_ROOT_DIR}/testu01 )
set( TestU01_INCLUDE_DIR ${TestU01_ROOT_DIR}/include )
set( TestU01_MYLIB_DIR ${TestU01_ROOT_DIR}/mylib )
set( TestU01_PROBDIST_DIR ${TestU01_ROOT_DIR}/probdist )
set( TestU01_EXAMPLES_DIR ${TestU01_ROOT_DIR}/examples )
set( TestU01_BUILD_DIR ${CMAKE_CURRENT_BINARY_DIR} )

set( CMAKE_MODULE_PATH "${TestU01_ROOT_DIR}/build/CMake/modules" )

# Disable compiler depreciation warnings.
add_definitions( -D_CRT_SECURE_NO_WARNINGS )

#---------------------------------------------------------
# deal with configuration & system introspection

include ( config.cmake )

#---------------------------------------------------------
# Extract the header files.

# Build the extractor, if it has not been build already.
set( tcode_BINARY_FILENAME tcode )
if( CMAKE_HOST_WIN32 )
	set( tcode_BINARY_FILENAME ${tcode_BINARY_FILENAME}.exe )
endif( CMAKE_HOST_WIN32 )
find_file( tcode_BINARY_FULLPATH ${tcode_BINARY_FILENAME} ${PROJECT_BINARY_DIR} ) 
if( NOT tcode_BINARY_FULLPATH )
	set( tcode_BINARY_FULLPATH ${PROJECT_BINARY_DIR}/${tcode_BINARY_FILENAME} )
	message( STATUS "Compiling mylib/tcode.c ..." )
	try_compile( COMPILED ${PROJECT_BINARY_DIR} ${TestU01_MYLIB_DIR}/tcode.c COPY_FILE ${tcode_BINARY_FULLPATH} )
	if( NOT COMPILED )
		message( ERROR "Compilation failed." )
	endif( NOT COMPILED )
endif( NOT tcode_BINARY_FULLPATH )
mark_as_advanced( tcode_BINARY_FULLPATH )

# Call the tcode binary to extract the header files that have not yet been extracted.
message( STATUS "Checking whether header files need extracting ..." )
foreach( Dir ${TestU01_TESTU01_DIR} ${TestU01_MYLIB_DIR} ${TestU01_PROBDIST_DIR} )
	file( GLOB TeX_FILES ${Dir}/*.tex )
	foreach( TeX_file ${TeX_FILES} )
		string( REPLACE ".tex" ".h" HeaderFilename ${TeX_file} )
		string( REPLACE "${Dir}/" "" HeaderFilename ${HeaderFilename} )
		execute_process( COMMAND ${tcode_BINARY_FULLPATH} "-check" ${TeX_file} 
		                 WORKING_DIRECTORY ${TestU01_INCLUDE_DIR} RESULT_VARIABLE result )
		#message( STATUS ${result} )
		if( result EQUAL 0 )
			#message( STATUS ${TeX_file} " contains no code." )
		else( result EQUAL 0 )
			find_file( header ${HeaderFilename} ${TestU01_INCLUDE_DIR} )
			if( NOT header )
				message( STATUS "Extracting " ${HeaderFilename} " from " ${TeX_file} " ..." )
				execute_process( COMMAND ${tcode_BINARY_FULLPATH} ${TeX_file} ${HeaderFilename} 
								 WORKING_DIRECTORY ${TestU01_INCLUDE_DIR} OUTPUT_VARIABLE output ERROR_VARIABLE error )
			endif( NOT header )
			mark_as_advanced( header )
			unset( header )
		endif( result EQUAL 0 )
	endforeach (TeX_file )
endforeach( Dir )

#---------------------------------------------------------
# Process headers and source files.

file( GLOB TestU01_HEADERS ${TestU01_INCLUDE_DIR}/*.h )
file( GLOB TestU01_SOURCES ${TestU01_TESTU01_DIR}/*.c )
file( GLOB TestU01_MYLIB ${TestU01_MYLIB_DIR}/*.h ${TestU01_MYLIB_DIR}/*.c )
file( GLOB TestU01_PROBDIST ${TestU01_PROBDIST_DIR}/*.h ${TestU01_PROBDIST_DIR}/*.c )
file( GLOB TestU01_EXAMPLES ${TestU01_EXAMPLES_DIR}/*.c )

# define a macro to create hierarchical source groups based on a dir tree
# Taken from QuantLib-CMake.
macro( create_source_group GroupPrefix RootDir ProjectSources  )
  set( DirSources ${ProjectSources} )
  foreach( Source ${DirSources} )
    string( REGEX REPLACE "${RootDir}" "" RelativePath "${Source}" )
    string( REGEX REPLACE "[\\\\/][^\\\\/]*$" "" RelativePath "${RelativePath}" )
    string( REGEX REPLACE "^[\\\\/]" "" RelativePath "${RelativePath}" )
    string( REGEX REPLACE "/" "\\\\\\\\" RelativePath "${RelativePath}" )
	#message( STATUS "${GroupPrefix}\\${RelativePath} FILES ${Source}" )
    source_group( "${GroupPrefix}\\${RelativePath}" FILES ${Source} )
  endforeach( Source )
endmacro( create_source_group )

create_source_group( "include" ${TestU01_INCLUDE_DIR} "${TestU01_HEADERS}" )
create_source_group( "testu01" ${TestU01_TESTU01_DIR} "${TestU01_SOURCES}" )
create_source_group( "mylib" ${TestU01_MYLIB_DIR} "${TestU01_MYLIB}" )
create_source_group( "probdist" ${TestU01_PROBDIST_DIR} "${TestU01_PROBDIST}" )
create_source_group( "examples" ${TestU01_EXAMPLES_DIR} "${TestU01_EXAMPLES}" )

#---------------------------------------------------------
# Create the library.

include_directories( ${TestU01_INCLUDE_DIR} )

if( NOT TestU01_BUILD_STATIC AND NOT TestU01_BUILD_SHARED ) 
  message( ERROR "Must build at least one static or shared version" )
endif()

if( TestU01_BUILD_STATIC )
  add_library( TestU01 STATIC ${TestU01_HEADERS} ${TestU01_SOURCES} ${TestU01_MYLIB} ${TestU01_PROBDIST} )
else( TestU01_BUILD_STATIC )
  add_library( TestU01 SHARED ${TestU01_HEADERS} ${TestU01_SOURCES} ${TestU01_MYLIB} ${TestU01_PROBDIST} )
endif( TestU01_BUILD_STATIC )

set_target_properties( TestU01 PROPERTIES
    VERSION ${TestU01_VERSION_STRING}
    OUTPUT_NAME "TestU01"
	FOLDER "TestU01"
)
target_link_libraries( TestU01 ${TestU01_LIBRARIES} )
add_dependencies( TestU01 TestU01 )
  
install( TARGETS TestU01
		 RUNTIME DESTINATION bin
		 LIBRARY DESTINATION lib
		 ARCHIVE DESTINATION lib
)

# install headers ----------------------------------------
install ( DIRECTORY ${TestU01_SRC_DIR} 
  DESTINATION include 
  FILES_MATCHING PATTERN "*.hpp" PATTERN "*.h"
)

# install FindTestU01-------------------------------------
install( FILES CMake/FindTestU01.cmake DESTINATION share/CMake )




