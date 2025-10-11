include(ExternalProject)

set(SQLITE_SOURCE_DIR  "${CMAKE_CURRENT_SOURCE_DIR}/../sqlite")
set(SQLITE_INSTALL_PATH "${CMAKE_CURRENT_BINARY_DIR}/sqlite-install/")
set(SQLITE_INSTALL_INCLUDE_PATH "${CMAKE_CURRENT_BINARY_DIR}/sqlite-install/include")

file(MAKE_DIRECTORY ${SQLITE_INSTALL_INCLUDE_PATH})

ExternalProject_Add(sqlite3_from_src
    SOURCE_DIR          "${CMAKE_CURRENT_LIST_DIR}/../sqlite/"
    INSTALL_DIR         "${SQLITE_INSTALL_PATH}"
    DOWNLOAD_COMMAND    ""
    CONFIGURE_COMMAND
        <SOURCE_DIR>/configure --prefix=<INSTALL_DIR> --enable-static --disable-shared
    BUILD_COMMAND
        make
    INSTALL_COMMAND
        make install
    
    LOG_CONFIGURE       1
    LOG_BUILD           1
    LOG_INSTALL         1
    
    USES_TERMINAL_CONFIGURE TRUE
    USES_TERMINAL_BUILD TRUE
)

ExternalProject_Add_Step(sqlite3_from_src make-build-dir
    COMMAND ${CMAKE_COMMAND} -E make_directory <BINARY_DIR>
    DEPENDERS configure
)

#ExternalProject_Add_Step(sqlite3_from_src make-install-include-dir
#    COMMAND ${CMAKE_COMMAND} -E make_directory <INSTALL_DIR>/include/
#    DEPENDERS configure
#)

ExternalProject_Get_Property(sqlite3_from_src INSTALL_DIR)

add_library(sqlite3 STATIC IMPORTED GLOBAL)
set_target_properties(sqlite3 PROPERTIES
    IMPORTED_LOCATION ${INSTALL_DIR}/lib/libsqlite3.a
    INTERFACE_INCLUDE_DIRECTORIES ${INSTALL_DIR}/include/)

add_dependencies(sqlite3 sqlite3_from_src)
