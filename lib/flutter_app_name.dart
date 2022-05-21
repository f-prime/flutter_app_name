library flutter_app_name;

import "package:rename/rename.dart";

import "android.dart" as android;
import "common.dart";
import "context.dart";
import "ios.dart" as ios;
import 'macos.dart' as macos;

void run() {
  final context = Context(
    yamlKeyName: "flutter_app_name",
    pubspecPath: "pubspec.yaml",
    iOSInfoPlistPath: "ios/Runner/Info.plist",
    macOSInfoPlistPath: "macos/Runner/Info.plist",
    androidManifestPath: "android/app/src/main/AndroidManifest.xml",
  );

  ios.updateLauncherName(context);
  android.updateLauncherName(context);
  macos.updateLauncherName(context);
  final id = fetchId(context);
  if (id != null) {
    changeBundleId(id, <Platform>[]);
  }
}
