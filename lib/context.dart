class Context {
  final String iOSInfoPlistPath;
  final String macOSInfoPlistPath;
  final String androidManifestPath;
  final String pubspecPath;
  final String yamlKeyName;

  Context({
    required this.yamlKeyName,
    required this.androidManifestPath,
    required this.pubspecPath,
    required this.iOSInfoPlistPath,
    required this.macOSInfoPlistPath,
  });
}
