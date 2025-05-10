import 'package:dartz/dartz.dart';
import 'package:nxt_assignment/feature/article/data/models/article_model.dart';

import '../../../core/errors/failure.dart';

abstract class ArticleRepository {
  Future<Either<Failure, List<ArticleModel>>> getArticles();
  Future<void> toggleFavorite(int articleId);
}