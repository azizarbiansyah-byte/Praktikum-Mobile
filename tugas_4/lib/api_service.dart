import 'dart:convert';
import 'package:http/http.dart' as http;
import 'article_model.dart';

class ApiService {
  static const _apiKey = '0b538dad1cab4cb89b11c6e92895cfac';
  static const _baseUrl =
        'https://newsapi.org/v2/everything?q=apple&from=2026-10-20&to=2026-10-20&sortBy=popularity&apiKey=$_apiKey';

  Future<List<Article>> fetchArticles() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(response.body);
        final List<dynamic> articlesJson = json['articles'];
        return articlesJson.map((json) => Article.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load articles');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server: $e');
    }
  }
}