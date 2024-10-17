import "package:xml/xml.dart";

import "context.dart";
import "common.dart" as common;

String fetchCurrentBundleName(Context context, String plistFileData) {
  final parsed = XmlDocument.parse(plistFileData);

  final allKeys = parsed.findAllElements("key");
  final allValues = parsed.findAllElements("string").toList();

  String? bundleName = null;

  allKeys.toList().asMap().forEach((key, val) {
    if (val.toString().contains("CFBundleName")) {
      bundleName = allValues[key].toString();
    }
  });

  if (bundleName == null) {
    throw Exception(
        "Bundle name not found in ${context.infoPlistPath}. Info.plist might be corrupt.");
  }

  return bundleName as String;
}

String setNewBundleName(Context context, String plistFileData,
    String currentBundleName, String desiredBundleName) {
  return plistFileData.replaceAll(
      currentBundleName, "<string>${desiredBundleName}</string>");
}

void updateLauncherName(Context context) {
  final String plistFileData = common.readFile(context.infoPlistPath);
  final String desiredBundleName = common.fetchLauncherName(context);
  final String currentBundleName =
      fetchCurrentBundleName(context, plistFileData);
  final String updatedPlistData = setNewBundleName(
      context, plistFileData, currentBundleName, desiredBundleName);

  common.overwriteFile(context.infoPlistPath, updatedPlistData);
}
