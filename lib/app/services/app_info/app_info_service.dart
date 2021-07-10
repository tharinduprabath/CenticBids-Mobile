abstract class AppInfoService {
  Future<AppInfo> getAppInfo();
}

class AppInfo {
  final String name;
  final String version;

  AppInfo({required this.name, required this.version});
}
