#----------------------------------------------------------------
# Generated CMake target import file for configuration "RelWithDebInfo".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "rlottie::rlottie" for configuration "RelWithDebInfo"
set_property(TARGET rlottie::rlottie APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(rlottie::rlottie PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELWITHDEBINFO "CXX"
  IMPORTED_LOCATION_RELWITHDEBINFO "/usr/lib/librlottie.a"
  )

list(APPEND _cmake_import_check_targets rlottie::rlottie )
list(APPEND _cmake_import_check_files_for_rlottie::rlottie "/usr/lib/librlottie.a" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
