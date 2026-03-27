import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/post.dart';

class ApiService {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';

  // Thêm header mặc định để tránh bị chặn (Error 403)
  final Map<String, String> _headers = {
    'Content-Type': 'application/json; charset=UTF-8',
    'User-Agent': 'Flutter-Lab8-App', // Định danh ứng dụng
  };

  Future<List<Post>> fetchPosts() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/posts'),
        headers: _headers, // Thêm headers vào đây
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);
        return jsonResponse.map((data) => Post.fromJson(data)).toList();
      } else {
        throw Exception('Server denied access (Status: ${response.statusCode})');
      }
    } catch (e) {
      // Nếu vẫn lỗi 403, có thể do mạng đang dùng Proxy/VPN chặn
      throw Exception('Network error: $e');
    }
  }

  Future<Post> createPost(String title, String body) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/posts'),
        headers: _headers,
        body: jsonEncode({
          'title': title,
          'body': body,
          'userId': 1,
        }),
      );

      if (response.statusCode == 201) {
        return Post.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to create post (Status: ${response.statusCode})');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
}
