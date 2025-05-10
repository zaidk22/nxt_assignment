import 'package:dartz/dartz.dart';
import 'package:nxt_assignment/feature/article/data/models/article_model.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/article_repository.dart';
import '../datasource/article_local_data_source.dart';
import '../datasource/article_remote_data_source.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final ArticleRemoteDataSource remoteDataSource;
  final ArticleLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  ArticleRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

@override
Future<Either<Failure, List<ArticleModel>>> getArticles() async {
  try {
    final localArticles = await localDataSource.getLastArticles();
    return Right(localArticles);
  } catch (e) {
    return Left(CacheFailure());
  }
}

  @override
  Future<void> toggleFavorite(int articleId) async {
    await localDataSource.toggleFavorite(articleId);
  }
}
