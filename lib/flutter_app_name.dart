library flutter_app_name;

import "package:rename/enums.dart";
import "package:rename/rename.dart";

import "context.dart";
import "common.dart";
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
  final id = fetchId(context);
  if (id != null) {
    Rename.fromTargets(targets: [
      RenamePlatform.android,
      RenamePlatform.ios,
      RenamePlatform.windows,
      RenamePlatform.web
    ]).applyWithCommandName(
        commandName: RenameCommand.setBundleId.name, value: id);
  }
}
