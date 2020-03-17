import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert' show json;

const accessKey = 'access';
const refreshKey = 'refresh';

class AuthService {
  final storage = new FlutterSecureStorage();

  AuthService();

  Future<String> readAccessToken() async {
    return await storage.read(key: accessKey);
  }

  Future<Map<String, String>> readAllTokens() async {
    return await storage.readAll();
  }

  void deleteAllTokens() async {
    await storage.deleteAll();
  }

  void saveAccessToken(String value) async {
    await storage.write(key: accessKey, value: value);
  }

  void saveRefreshToken(String value) async {
    await storage.write(key: refreshKey, value: value);
  }

  Future<String> login(String email, String password) async {
    var res = await http.post('https://dev.ritchie.app/user/auth/token/',
        body: {'email': 'test1@citizn.world', 'password': 'TestUser123!'});

    if (res.statusCode == 200) {
      var jwt = res.body;
      if (jwt != null) {
        var tokens = json.decode(jwt);
        var accessToken = tokens['access'];
        saveAccessToken(accessToken);
        var refreshToken = tokens['refresh'];
        saveRefreshToken(refreshToken);
        print('login successful - tokens saved');
        return accessToken;
      }
    } else {
      throw Exception('Login returned ${res.statusCode}');
    }
  }

  Future<String> fetchTestData() async {
    var accessToken = await readAccessToken();
    print('access token found $accessToken');
    if (accessToken == null || accessToken.isEmpty) {
      print('no access token found');
      accessToken = await login('', '');
    }

    String result;
    http.Response response = await http.get(
        "https://dev.ritchie.app/user/v1/BillDetailsGet/8115",
        headers: <String, String>{
          HttpHeaders.authorizationHeader: 'JWT ' + accessToken
        });

    if (response.statusCode == 200) {
      var content = json.decode(response.body);
      // replace any character that isn't a whitespace, word or newline character, with two spacaes
      result = content[2]['text_en']
          .toString()
          .replaceAll(RegExp(r"[^\s\w\n]"), '  ');
    } else {
      result = "Failed to retrieve data with ${response.statusCode}";
    }
    return result;
  }
}
