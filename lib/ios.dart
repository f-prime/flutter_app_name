import "package:xml/xml.dart";

import "context.dart";
import "common.dart" as common;

Map<String, String> fetchCurrentBundleNames(
    Context context, String plistFileData) {
  final parsed = XmlDocument.parse(plistFileData);

  final allKeys = parsed.findAllElements("key");
  final allValues = parsed.findAllElements("string").toList();

  Map<String, String> bundleNames = {};

  allKeys.toList().asMap().forEach((key, val) {
    if (val.toString().contains("CFBundleName")) {
      bundleNames["CFBundleName"] = allValues[key].toString();
    }
    if (val.toString().contains("CFBundleDisplayName")) {
      bundleNames["CFBundleDisplayName"] = allValues[key].toString();
    }
  });

  if (bundleNames["CFBundleName"] == null) {
    throw Exception(
        "Bundle name not found in ${context.infoPlistPath}. Info.plist might be corrupt.");
  }

  return bundleNames;
}

String setNewBundleName(Context context, String plistFileData,
    Map<String, String> currentBundleNames, String desiredBundleName) {
  var updatedPlistFileData = plistFileData;
  currentBundleNames.forEach((_, value) {
    updatedPlistFileData = updatedPlistFileData.replaceAll(
        value, "<string>${desiredBundleName}</string>");
  });
  return updatedPlistFileData;
}

void updateLauncherName(Context context) {
  final String plistFileData = common.readFile(context.infoPlistPath);
  final String desiredBundleName = common.fetchLauncherName(context);
  final Map<String, String> currentBundleNames =
      fetchCurrentBundleNames(context, plistFileData);
  final String updatedPlistData = setNewBundleName(
      context, plistFileData, currentBundleNames, desiredBundleName);

  common.overwriteFile(context.infoPlistPath, updatedPlistData);
}
