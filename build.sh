xcodebuild -sdk iphoneos -arch armv7 -arch armv7s -arch arm64 clean build
xcodebuild -sdk iphonesimulator -arch i386 -arch i686 clean build

xcrun lipo -create build/Release-iphonesimulator/libUZMultipleLayeredPopoverController.a build/Release-iphoneos/libUZMultipleLayeredPopoverController.a -output build/libUZMultipleLayeredPopoverController.a
cp ./UZMultipleLayeredPopoverController/UZMultipleLayeredPopoverController.h ./build/
