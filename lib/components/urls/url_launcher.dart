import 'package:url_launcher/url_launcher.dart';

launchURL(String uri) async {
  final Uri url = Uri.parse(uri);
  if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
    throw Exception('Could not launch $url');
  }
}



