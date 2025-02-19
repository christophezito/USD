#
# Copyright 2018 Pixar
#
# Licensed under the terms set forth in the LICENSE.txt file available at
# https://openusd.org/license.
#

# Find OSL header.
find_path(OSL_INCLUDE_DIR
    NAMES
        OSL/oslversion.h
    PATH_SUFFIXES
        include/
    HINTS
        "${OSL_LOCATION}"
        "$ENV{OSL_LOCATION}"
    DOC
        "OSL headers path"
    )

# Parse OSL version.
if(OSL_INCLUDE_DIR)
    set(osl_config_file "${OSL_INCLUDE_DIR}/OSL/oslversion.h")
    if(EXISTS ${osl_config_file})
        file(STRINGS
                ${osl_config_file}
                TMP
                REGEX "#define OSL_LIBRARY_VERSION_MAJOR.*$")
        string(REGEX MATCHALL "[0-9]+" OSL_MAJOR_VERSION ${TMP})
        file(STRINGS
                ${osl_config_file}
                TMP
                REGEX "#define OSL_LIBRARY_VERSION_MINOR.*$")
        string(REGEX MATCHALL "[0-9]+" OSL_MINOR_VERSION ${TMP})
        file(STRINGS
                ${osl_config_file}
                TMP
                REGEX "#define OSL_LIBRARY_VERSION_PATCH.*$")
        string(REGEX MATCHALL "[0-9]+" OSL_PATCH_VERSION ${TMP})

        string(JOIN "." OSL_VERSION
               ${OSL_MAJOR_VERSION} ${OSL_MINOR_VERSION} ${OSL_PATCH_VERSION})
    endif()
endif()

# Find libraries and binaries

# OSL v1.11.0+ provide the shader install directory
# in a macro in OSL/oslversion.h, but for older versions
# we need to find this location ourselves.
if (${OSL_VERSION} VERSION_LESS "1.11.0")
    find_path (OSL_SHADER_INSTALL_DIR
        NAMES
            stdosl.h
        HINTS
            "${OSL_LOCATION}/shaders"
            "$ENV{OSL_LOCATION}/shaders"
    )
endif()

find_library (OSL_EXEC_LIBRARY
    NAMES
        oslexec
    PATH_SUFFIXES
        lib/
    HINTS
        "${OSL_LOCATION}"
        "$ENV{OSL_LOCATION}"
    )
find_library (OSL_COMP_LIBRARY
    NAMES
        oslcomp
    PATH_SUFFIXES
        lib/
    HINTS
        "${OSL_LOCATION}"
        "$ENV{OSL_LOCATION}"
    )
find_library (OSL_QUERY_LIBRARY
    NAMES
        oslquery
    PATH_SUFFIXES
        lib/
    HINTS
        "${OSL_LOCATION}"
        "$ENV{OSL_LOCATION}"
    )
find_program (OSL_OSLC_EXECUTABLE
    NAMES
        oslc
    PATH_SUFFIXES
        bin/
    HINTS
        "${OSL_LOCATION}"
        "$ENV{OSL_LOCATION}"
    )
find_program (OSL_OSLINFO_EXECUTABLE
    NAMES
        oslinfo
    PATH_SUFFIXES
        bin/
    HINTS
        "${OSL_LOCATION}"
        "$ENV{OSL_LOCATION}"
    )

include (FindPackageHandleStandardArgs)

if (${OSL_VERSION} VERSION_LESS "1.11.0")
    find_package_handle_standard_args (OSL
        DEFAULT_MSG
        OSL_INCLUDE_DIR
        OSL_EXEC_LIBRARY
        OSL_COMP_LIBRARY
        OSL_QUERY_LIBRARY
        OSL_SHADER_INSTALL_DIR
        OSL_OSLC_EXECUTABLE
        OSL_OSLINFO_EXECUTABLE
    )
else()
    find_package_handle_standard_args (OSL
        DEFAULT_MSG
        OSL_INCLUDE_DIR
        OSL_EXEC_LIBRARY
        OSL_COMP_LIBRARY
        OSL_QUERY_LIBRARY
        OSL_OSLC_EXECUTABLE
        OSL_OSLINFO_EXECUTABLE
    )
endif()
