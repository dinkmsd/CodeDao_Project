import 'dart:convert';

import 'package:helper/data/modules.dart';
import 'package:helper/data/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AuthRepository {
  static Future<String> loadUsername() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString('username') ?? '';
    } catch (e) {
      throw (e);
    }
  }

  static Future<void> logout() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('username', '');
    } catch (e) {
      rethrow;
    }
  }

  static Future<User> getUserInfo(String username) async {
    try {
      final uriServer =
          Uri.parse('https://codedao-server.onrender.com/get-info/$username');
      final response = await http.get(uriServer);
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        final userInfo = User(
            username: body['username'],
            email: body['email'],
            fullname: body['fullname']);
        return userInfo;
      }
      throw Exception('Cant get data');
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<NewWordInfo>> getListWords(String username) async {
    try {
      var url = Uri(
          scheme: 'https',
          host: 'codedao-server.onrender.com',
          path: '/list-word/$username');
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body)['listWords'];
        print("Call me baby");
        print(body);
        List<NewWordInfo> words = <NewWordInfo>[];
        for (var item in body) {
          var w = NewWordInfo.fromJson(item);
          words.add(w);
        }
        return words;
      } else {
        throw Exception('Bad response');
      }
    } catch (exp) {
      throw Exception('Failed to request network call: Get List Words');
    }
  }

  static Future<void> submitRegister(RegisterInfo registerInfo) async {
    final body = registerInfo.toJson();
    final uriServer =
        Uri.parse('https://codedao-server.onrender.com/user/register');

    try {
      final response = await http.post(
        uriServer,
        body: jsonEncode(body),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 300) {
        throw Exception('Account existed !');
      }
    } catch (exp) {
      rethrow;
    }
  }
}
