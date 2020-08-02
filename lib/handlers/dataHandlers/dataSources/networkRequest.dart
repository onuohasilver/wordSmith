import 'package:http/http.dart' as http;
import 'dart:convert';

class GetDefinition {
  GetDefinition(this.word);
  final String word;
  Future<String> getData() async {
    print('getting respose');
    String ca;
    http.Response response = await http.get(
        'https://dictionaryapi.com/api/v3/references/collegiate/json/$word?key=a65cce6e-c172-4c7d-a729-fe29763a24f7');
    if (response.statusCode == 200) {
      String data = response.body;
      dynamic decodedData = jsonDecode(data);
      ca = (decodedData[0]['shortdef'][0]);
    } else {
      print(response.statusCode);
    }
    // print(ca);
    return ca;
  }
}
