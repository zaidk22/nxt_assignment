import 'package:dartz/dartz.dart';
import 'package:nxt_assignment/feature/article/data/models/article_model.dart';

import '../../../../core/errors/failure.dart';
import '../article_repository.dart';

class GetArticles {
  final ArticleRepository repository;

  GetArticles(this.repository);

  Future<Either<Failure, List<ArticleModel>>> call() async {
    return await repository.getArticles();
  }
}