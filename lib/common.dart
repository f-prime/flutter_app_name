import "dart:io";

import "package:yaml/yaml.dart";

import "context.dart";

String readFile(String filePath) {
  final File fileObj = File(filePath);
  return fileObj.readAsStringSync();
}

void overwriteFile(String filePath, String fileData) {
  final File fileObj = File(filePath);
  fileObj.writeAsString(fileData);
}

Map readYamlFile(String yamlFilePath) {
  final File yamlFile = File(yamlFilePath);
  final Map yamlData = loadYaml(yamlFile.readAsStringSync());

  return yamlData;
}

Map getYamlKeyData(Context context) {
  final String yamlFilePath = context.pubspecPath;
  final String yamlKeyName = context.yamlKeyName;

  final Map yamlData = readYamlFile(yamlFilePath);
  final Map? yamlKeyData = yamlData[yamlKeyName];

  if (yamlKeyData == null) {
    throw Exception(
        "Your pubspec.yaml file must have a key ${yamlKeyName} in it.");
  }

  return yamlKeyData;
}

String fetchLauncherName(Context context) {
  final yamlKeyName = context.yamlKeyName;

  final Map yamlData = getYamlKeyData(context);
  final String? launcherName = yamlData["name"];

  if (launcherName == null) {
    throw Exception(
        "You must set the launcher name under the '${yamlKeyName}' section of your pubspec.yaml file.");
  }

  return launcherName;
}

String? fetchId(Context context) {
  final Map yamlData = getYamlKeyData(context);
  final String? id = yamlData["id"];

  return id;
}
