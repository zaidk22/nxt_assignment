import 'package:http/http.dart' as http;

class ApiClient {
  final http.Client client;

  ApiClient({required this.client});

  Future<dynamic> get(String url) async {
    final response = await client.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load data');
    }
  }
}