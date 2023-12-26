cd ../.isar
bash tool/build_android.sh arm64
mv libisar_android_arm64.so libisar.so
mv libisar.so ../onyx/.pub-cache/hosted/pub.dev/isar_flutter_libs-*/android/src/main/jniLibs/arm64-v8a/
cd ../onyx
