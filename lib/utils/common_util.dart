import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

// ignore: avoid_classes_with_only_static_members
class CommonUtil {
  static const String apiUrl = 'http://192.168.1.100:4242';
  static const String stripeUserCreate = '/add/user';
  static const String checkOut = '/checkout';

  ///
  static Future<http.Response> backendCall(User user, String endPoint) async {
    final token = await user.getIdToken();
    return http.post(
      Uri.parse('$apiUrl$endPoint'),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
  }
}
