#!/usr/bin/env bash
set -euo pipefail

RLOTTIE_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BUILD_ROOT="${RLOTTIE_ROOT}/build/xcframework"
XCODE_PROJECT_DIR="${BUILD_ROOT}/xcode_project"
PRODUCTS_DIR="${BUILD_ROOT}/products"
DEVICE_BUILD_DIR="${PRODUCTS_DIR}/ios-arm64"
SIMULATOR_BUILD_DIR="${PRODUCTS_DIR}/ios-arm64-simulator"
XCFRAMEWORK_OUTPUT="${RLOTTIE_ROOT}/rlottie.xcframework"

# Keep this in sync with the app minimum iOS version.
IOS_DEPLOYMENT_TARGET="${IOS_DEPLOYMENT_TARGET:-15.0}"

COMMON_CPP_DEFINES="-DLOTTIE_DISABLE_ARM_NEON=1 -DLOTTIE_THREAD_SAFE=1 -DLOTTIE_IMAGE_MODULE_DISABLED=1"
COMMON_CXX_FLAGS="${COMMON_CPP_DEFINES} -Wno-error=shorten-64-to-32"
COMMON_C_FLAGS="${COMMON_CPP_DEFINES}"

echo "Cleaning previous outputs..."
rm -rf "${BUILD_ROOT}" "${XCFRAMEWORK_OUTPUT}"
mkdir -p "${XCODE_PROJECT_DIR}" "${DEVICE_BUILD_DIR}" "${SIMULATOR_BUILD_DIR}"

echo "Configuring CMake project..."
cmake -S "${RLOTTIE_ROOT}" -B "${XCODE_PROJECT_DIR}" -G "Xcode" \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_POLICY_DEFAULT_CMP0063=NEW \
  -DCMAKE_POLICY_VERSION_MINIMUM=3.5 \
  -DBUILD_SHARED_LIBS=OFF \
  -DENABLE_RLOTTIE_EXAMPLES=OFF \
  -DCMAKE_CXX_STANDARD=17 \
  -DCMAKE_OSX_DEPLOYMENT_TARGET="${IOS_DEPLOYMENT_TARGET}" \
  -DCMAKE_CXX_FLAGS="${COMMON_CXX_FLAGS}" \
  -DCMAKE_C_FLAGS="${COMMON_C_FLAGS}"

echo "Building for iOS Device (arm64), iOS ${IOS_DEPLOYMENT_TARGET}..."
xcodebuild -project "${XCODE_PROJECT_DIR}/rlottie.xcodeproj" \
  -scheme "rlottie" \
  -configuration Release \
  -sdk iphoneos \
  CONFIGURATION_BUILD_DIR="${DEVICE_BUILD_DIR}" \
  ONLY_ACTIVE_ARCH=NO \
  SKIP_INSTALL=NO \
  BUILD_LIBRARIES_FOR_DISTRIBUTION=YES \
  IPHONEOS_DEPLOYMENT_TARGET="${IOS_DEPLOYMENT_TARGET}" \
  build

echo "Building for iOS Simulator (arm64), iOS ${IOS_DEPLOYMENT_TARGET}..."
xcodebuild -project "${XCODE_PROJECT_DIR}/rlottie.xcodeproj" \
  -scheme "rlottie" \
  -configuration Release \
  -sdk iphonesimulator \
  CONFIGURATION_BUILD_DIR="${SIMULATOR_BUILD_DIR}" \
  ONLY_ACTIVE_ARCH=NO \
  SKIP_INSTALL=NO \
  BUILD_LIBRARIES_FOR_DISTRIBUTION=YES \
  IPHONEOS_DEPLOYMENT_TARGET="${IOS_DEPLOYMENT_TARGET}" \
  build

DEVICE_LIB="${DEVICE_BUILD_DIR}/librlottie.a"
SIMULATOR_LIB="${SIMULATOR_BUILD_DIR}/librlottie.a"
HEADERS_DIR="${RLOTTIE_ROOT}/inc"

[[ -f "${DEVICE_LIB}" ]] || { echo "Device library not found: ${DEVICE_LIB}"; exit 1; }
[[ -f "${SIMULATOR_LIB}" ]] || { echo "Simulator library not found: ${SIMULATOR_LIB}"; exit 1; }
[[ -d "${HEADERS_DIR}" ]] || { echo "Headers directory not found: ${HEADERS_DIR}"; exit 1; }

echo "Creating XCFramework..."
xcodebuild -create-xcframework \
  -library "${DEVICE_LIB}" -headers "${HEADERS_DIR}" \
  -library "${SIMULATOR_LIB}" -headers "${HEADERS_DIR}" \
  -output "${XCFRAMEWORK_OUTPUT}"

echo "Done: ${XCFRAMEWORK_OUTPUT}"