#!/bin/sh
set -e
if test "$CONFIGURATION" = "Debug"; then :
  cd /Users/e.a.kolesnikov/rlottie-telegram/rlottie-telegram-fork/rlottie/build/xcframework/xcode_project
  make -f /Users/e.a.kolesnikov/rlottie-telegram/rlottie-telegram-fork/rlottie/build/xcframework/xcode_project/CMakeScripts/ReRunCMake.make
fi
if test "$CONFIGURATION" = "Release"; then :
  cd /Users/e.a.kolesnikov/rlottie-telegram/rlottie-telegram-fork/rlottie/build/xcframework/xcode_project
  make -f /Users/e.a.kolesnikov/rlottie-telegram/rlottie-telegram-fork/rlottie/build/xcframework/xcode_project/CMakeScripts/ReRunCMake.make
fi
if test "$CONFIGURATION" = "MinSizeRel"; then :
  cd /Users/e.a.kolesnikov/rlottie-telegram/rlottie-telegram-fork/rlottie/build/xcframework/xcode_project
  make -f /Users/e.a.kolesnikov/rlottie-telegram/rlottie-telegram-fork/rlottie/build/xcframework/xcode_project/CMakeScripts/ReRunCMake.make
fi
if test "$CONFIGURATION" = "RelWithDebInfo"; then :
  cd /Users/e.a.kolesnikov/rlottie-telegram/rlottie-telegram-fork/rlottie/build/xcframework/xcode_project
  make -f /Users/e.a.kolesnikov/rlottie-telegram/rlottie-telegram-fork/rlottie/build/xcframework/xcode_project/CMakeScripts/ReRunCMake.make
fi

