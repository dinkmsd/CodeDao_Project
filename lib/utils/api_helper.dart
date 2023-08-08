import 'dart:convert';
import 'package:helper/data/modules.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiHelper {
  static Future<String> loadUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('username') ?? '';
  }

  static Future<void> setUsername(String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', username);
  }

  static Future<void> loginUser(LoginInfo loginInfo) async {
    try {
      final body = {
        'username': loginInfo.userName,
        'password': loginInfo.password,
      };
      final uriServer =
          Uri.parse('https://codedao-server.onrender.com/user/login');
      final response = await http.post(
        uriServer,
        body: jsonEncode(body),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode != 200) {
        throw Exception('Username or password was wrong');
      }
    } catch (exp) {
      throw Exception('Failed to request network call: $exp');
    }
  }

  static Future<List<NewInfo>> getListNews() async {
    try {
      var url = Uri(
          scheme: 'https', host: 'codedao-server.onrender.com', path: '/news');
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        List<NewInfo> listNews = <NewInfo>[];
        for (var item in body) {
          var w = NewInfo.formJson(item);
          listNews.add(w);
        }
        return listNews;
      } else {
        throw Exception('Bad response');
      }
    } catch (exp) {
      throw Exception('Failed to request network call: $exp');
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

  static Future<void> deleteListWords(String username, String word) async {
    try {
      var url = Uri(
          scheme: 'https',
          host: 'codedao-server.onrender.com',
          path: '/delete-word/$username/$word');
      await http.delete(url);
    } catch (exp) {
      throw Exception('Failed to request network call: Delete Word');
    }
  }

  static Future<void> addListWords(String username, NewWordInfo word) async {
    try {
      var url = Uri(
          scheme: 'https',
          host: 'codedao-server.onrender.com',
          path: '/user/add-new-word');
      await http.post(url,
          body: jsonEncode(word.toJsonWithUsername(username)),
          headers: {'Content-Type': 'application/json'});
    } catch (exp) {
      throw Exception('Failed to request network call: Add Word');
    }
  }

  static Future<void> updateListWords(String username, NewWordInfo word) async {
    try {
      var url = Uri(
          scheme: 'https',
          host: 'codedao-server.onrender.com',
          path: '/word-update/$username/${word.word}');
      final body = {'favourite': word.favourite};
      final response = await http.put(url,
          body: jsonEncode(body),
          headers: {'Content-Type': 'application/json'});
      print(response.body);
    } catch (exp) {
      throw Exception('Failed to request network call');
    }
  }

  static Future<http.Response> googleSearchWord(String word) async {
    try {
      final String encodeWord = Uri.encodeComponent(word);
      final url = Uri.parse(
          'https://translate.googleapis.com/translate_a/single?client=gtx&sl=en&tl=vi&dt=t&q=$encodeWord');
      http.Response response = await http.get(url);
      return response;
    } catch (exp) {
      throw Exception('Failed to request network call');
    }
  }

  static Future<String> getMeaningFromGoogle(String word) async {
    try {
      http.Response responseFromGoogle = await ApiHelper.googleSearchWord(word);
      var decodeFromGoogle = jsonDecode(responseFromGoogle.body);
      return decodeFromGoogle[0][0][0];
    } catch (e) {
      throw Exception(
          'Failed to request network call: Get meaning from google');
    }
  }

  static Future<http.Response> apiSearchWord(String word) async {
    try {
      var url =
          Uri.parse("https://api.dictionaryapi.dev/api/v2/entries/en/$word");
      http.Response response = await http.get(url);
      return response;
    } catch (e) {
      throw Exception('Failed to request network call');
    }
  }

  static WordModel getWordModelsFromResponse(http.Response response) {
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      WordModel word = WordModel(
          id: -1,
          word: body[0]['word'],
          definition: body[0]['meanings'][0]['definitions'][0]['definition'],
          type: body[0]['meanings'][0]['partOfSpeech'],
          example: body[0]['meanings'][0]['definitions'][0]['example'] ?? '');
      return word;
    } else {
      throw Exception('Bad response');
    }
  }

  static Future<NewWordInfo> getWordModels(String word) async {
    http.Response responseFromApi = await apiSearchWord(word);
    var decodeFromApi = getWordModelsFromResponse(responseFromApi);

    http.Response responseFromGoogle = await googleSearchWord(word);
    var decodeFromGoogle = jsonDecode(responseFromGoogle.body);

    return NewWordInfo(
        id: 'null',
        word: word,
        meaning: decodeFromGoogle[0][0][0],
        favourite: false,
        describe: decodeFromApi.definition,
        type: decodeFromApi.type);
  }
}
