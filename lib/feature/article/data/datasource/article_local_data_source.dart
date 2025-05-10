import 'package:hive/hive.dart';

import '../models/article_model.dart';

abstract class ArticleLocalDataSource {
  Future<List<ArticleModel>> getLastArticles();
  Future<void> cacheArticles(List<ArticleModel> articles);
  Future<void> toggleFavorite(int articleId);
}

class ArticleLocalDataSourceImpl implements ArticleLocalDataSource {
  static const String _boxName = 'articles';
  late Box<ArticleModel> _articleBox;

  ArticleLocalDataSourceImpl();

  Future<void> init() async {
    _articleBox = await Hive.openBox<ArticleModel>(_boxName);
  }

  @override
  Future<List<ArticleModel>> getLastArticles() async {
    await init();
    return _articleBox.values.toList();
  }

@override
Future<void> cacheArticles(List<ArticleModel> articles) async {
  await init();
  await _articleBox.clear();

  for (var article in articles) {
    await _articleBox.put(article.id, article);
  }
}


  @override
  Future<void> toggleFavorite(int articleId) async {
    await init();
    final article = _articleBox.values.firstWhere(
          (article) => article.id == articleId,
      orElse: () => throw Exception('Article not found'),
    );

    await _articleBox.put(
      articleId,
      article.copyWith(isFavorite: !article.isFavorite),
    );
  }
}