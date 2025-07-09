import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:chea/utils/auth_service.dart';
import 'package:chea/models/home_model.dart';


class BlogService {
  final String baseUrl = 'http://172.28.102.117:8000/blogs/';

  Future<List<Blog>> fetchRecentBlogs() async {
    final response = await http.get(Uri.parse('${baseUrl}all/'));
    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      final blogs = data.map((e) => Blog.fromJson(e)).toList();
      blogs.sort((a, b) => b.date.compareTo(a.date));
      return blogs.take(5).toList();
    } else {
      throw Exception('Failed to load blogs');
    }
  }
}

class OpportunityService {
  final String baseUrl = 'http://172.28.102.117:8000/opportunities/';

  Future<List<Opportunity>> fetchRecentOpportunities() async {
    final token = await AuthService().getToken();
    final response = await http.get(
      Uri.parse('${baseUrl}opportunities/'),
      headers: {'Authorization': 'Token $token'},
    );

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      final opportunities = data.map((e) => Opportunity.fromJson(e)).toList();
      opportunities.sort((a, b) =>
          DateTime.parse(b.lastDateOfApply).compareTo(DateTime.parse(a.lastDateOfApply)));
      return opportunities.take(4).toList();
    } else {
      throw Exception('Failed to load recent opportunities');
    }
  }
}
