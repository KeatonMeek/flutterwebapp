import '../models/anagram_model.dart';
import 'package:http/http.dart' as http;

class AnagramService {
  Future<AnagramModel> getAnagram(String letters) async {
    var client = http.Client();

    var uri = Uri.parse('http://anagramwebapp.azurewebsites.net/anagrams?letters=$letters');
    var response = await client.get(uri);

    if (response.statusCode == 200) {
      var json = response.body;
      print(json);
      return anagramModelFromJson(json);
    }
    throw "ERROR: Unable to return Json";
  }
}
