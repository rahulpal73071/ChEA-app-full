import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'blog_model.dart';
import '../../../utils/auth_service.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

class BlogService {
  final String baseUrl = 'http://172.28.102.117:8000/blogs/'; // change if needed

  Future<List<Blog>> fetchBlogsByType(String type) async {
    final response = await http.get(Uri.parse('$baseUrl$type/'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Blog.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load blogs');
    }
  }

  Future<List<Blog>> fetchAllBlogs() async {
    final response = await http.get(Uri.parse('${baseUrl}all/'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Blog.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load blogs');
    }
  }

  Future<bool> createBlog({
    required String name,
    required String title,
    required String thought,
    required String blogType,
    required File imageFile,
  }) async {
    final token = await AuthService().getToken();
    final uri = Uri.parse('${baseUrl}create/');
    final request = http.MultipartRequest('POST', uri);

    request.headers['Authorization'] = 'Token $token';

    request.fields['name'] = name;
    request.fields['title'] = title;
    request.fields['thought'] = thought;
    request.fields['blog_type'] = blogType;

    final mimeType = lookupMimeType(imageFile.path)?.split('/');
    if (mimeType != null && mimeType.length == 2) {
      final image = await http.MultipartFile.fromPath(
        'image',
        imageFile.path,
        contentType: MediaType(mimeType[0], mimeType[1]),
      );
      request.files.add(image);
    }

    final response = await request.send();

    return response.statusCode == 201;
  }
}
