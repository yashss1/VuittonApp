import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper(this.url);

  final String url;

  Future getData() async {
    // http.Response response = await http.get(Uri.parse(url));
    // http.Response response = await http.get(Uri.parse(url));
    http.Response response = await http.get(Uri.parse(url), headers: {
      "Accept": "application/json",
      "Authorization": "Bearer pk_ijrd7TS53wADeNs6S1pcgoYXVYn4wbyL"
    });
    if (response.statusCode == 200) {
      String data = response.body;
      var decodedData = jsonDecode(data);
      return decodedData;
    } else {
      print(response.statusCode);
    }
  }
}
