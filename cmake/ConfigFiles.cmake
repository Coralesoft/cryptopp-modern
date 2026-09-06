# ===-----------------------------------------------------------------------===#
# Distributed under the 3-Clause BSD License. See accompanying file LICENSE or
# copy at https://opensource.org/licenses/BSD-3-Clause).
# SPDX-License-Identifier: BSD-3-Clause
# ===-----------------------------------------------------------------------===#

include(CMakePackageConfigHelpers)

# ------------------------------------------------------------------------------
# Generate module config files for cmake and pkgconfig
# ------------------------------------------------------------------------------
function(_module_cmake_config_files)
    message(STATUS "[cryptopp-modern] Generating cmake package config files")
    write_basic_package_version_file(
        ${CMAKE_CURRENT_BINARY_DIR}/cryptopp-modernConfigVersion.cmake
        COMPATIBILITY SameMajorVersion
    )
endfunction()

function(_module_pkgconfig_files)
    message(STATUS "[cryptopp-modern] Generating pkgconfig files")

    # The link name is resolved per configuration at generate time, so a
    # postfix or OUTPUT_NAME on the target is reflected without inspecting
    # the build type here.
    set(MODULE_LINK_LIBS "-l$<TARGET_FILE_BASE_NAME:cryptopp>")

    # Keep relative pkg-config paths relative to ${prefix}, but pass absolute
    # GNUInstallDirs overrides through unchanged.
    foreach(_dir LIBDIR INCLUDEDIR DATAROOTDIR)
        if(IS_ABSOLUTE "${CMAKE_INSTALL_${_dir}}")
            set(PC_${_dir} "${CMAKE_INSTALL_${_dir}}")
        else()
            set(PC_${_dir} "\${prefix}/${CMAKE_INSTALL_${_dir}}")
        endif()
    endforeach()

    # Primary file is named libcryptopp.pc to match upstream Crypto++, so
    # `pkg-config libcryptopp` keeps working for existing consumers. Paths and
    # the version are substituted now; the link name is written per
    # configuration by file(GENERATE).
    configure_file(
        ${CMAKE_CURRENT_SOURCE_DIR}/cmake/config.pc.in
        ${CMAKE_CURRENT_BINARY_DIR}/libcryptopp.pc.configured
        @ONLY
    )
    file(GENERATE
        OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/$<CONFIG>/libcryptopp.pc
        INPUT ${CMAKE_CURRENT_BINARY_DIR}/libcryptopp.pc.configured
    )

    # Alias for consumers that adopted the fork's cryptopp-modern name; it
    # forwards to libcryptopp rather than repeating the flags.
    configure_file(
        ${CMAKE_CURRENT_SOURCE_DIR}/cmake/config-alias.pc.in
        ${CMAKE_CURRENT_BINARY_DIR}/cryptopp-modern.pc
        @ONLY
    )
endfunction()

function(create_module_config_files)
    _module_cmake_config_files()
    _module_pkgconfig_files()
endfunction()
