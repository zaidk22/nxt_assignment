import 'dart:convert';

import 'package:nxt_assignment/core/errors/exceptions.dart';

import '../../../../core/network/api_client.dart';
import '../models/article_model.dart';

abstract class ArticleRemoteDataSource {
  Future<List<ArticleModel>> getArticles();
}

class ArticleRemoteDataSourceImpl implements ArticleRemoteDataSource {
  final ApiClient apiClient;

  ArticleRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<List<ArticleModel>> getArticles() async {
    try {
     

  final rawResponse = await apiClient.get('https://jsonplaceholder.typicode.com/posts');

// Assuming apiClient.get() returns a raw JSON string
final decoded = jsonDecode(rawResponse) as List;

return decoded
    .map((json) => ArticleModel.fromJson(json))
    .toList();

    } catch (e) {
      print(e);
      throw ServerException();
    }
  }
}
