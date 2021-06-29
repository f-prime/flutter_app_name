library flutter_app_name;

import "context.dart";

import "ios.dart" as ios;
import "android.dart" as android;

void run() {
  final context = Context(
    yamlKeyName: "flutter_app_name",
    pubspecPath: "pubspec.yaml",
    infoPlistPath: "ios/Runner/Info.plist",
    androidManifestPath: "android/app/src/main/AndroidManifest.xml",
  );

  ios.updateLauncherName(context);
  android.updateLauncherName(context);
}
