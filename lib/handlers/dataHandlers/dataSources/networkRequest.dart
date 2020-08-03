import 'package:http/http.dart' as http;
import 'dart:convert';
///Retrieve word definitions from the dictionay API
//TODO: Consider working on the request that return list values
class GetDefinition {
  GetDefinition(this.word);
  final String word;
  Future<String> getData() async {
    String ca;
    http.Response response = await http.get(
        'https://dictionaryapi.com/api/v3/references/collegiate/json/$word?key=a65cce6e-c172-4c7d-a729-fe29763a24f7');
    if (response.statusCode == 200) {
      String data = response.body;
      var decodedData = jsonDecode(data);
      ca = (decodedData[0]['shortdef'][0]);
    } else {
      print(response.statusCode);
    }
    // print(ca);
    return ca;
  }
}
