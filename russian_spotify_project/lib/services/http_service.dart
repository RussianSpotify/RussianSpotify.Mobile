import 'package:http/http.dart' as http;

class HttpService {
  final String baseUrl;

  HttpService({required this.baseUrl});

  Future<int> getSongPlaysNumber(String songId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/Song/GetSongPlaysNumber/$songId'),
    );

    if (response.statusCode == 200) {
      return int.parse(response.body);
    } else {
      throw Exception('Failed to load plays number');
    }
  }

  Future<void> updateSongPlaysNumber(String songId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/Song/UpdateSongPlaysNumber'),
      body: {'songId': songId},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update plays number');
    }
  }
} 