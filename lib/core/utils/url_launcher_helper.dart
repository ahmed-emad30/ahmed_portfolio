import 'package:url_launcher/url_launcher.dart';

sealed class UrlLauncherHelper {
  static Future<bool> open(String rawUrl) async {
    final url = rawUrl.trim();
    if (url.isEmpty) return false;

    final uri = Uri.tryParse(url);
    if (uri == null) return false;

    if (await canLaunchUrl(uri)) {
      return launchUrl(uri, mode: LaunchMode.externalApplication);
    }
    return false;
  }
}
