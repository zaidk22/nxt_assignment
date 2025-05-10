
import '../article_repository.dart';

class ToggleFavorite {
  final ArticleRepository repository;

  ToggleFavorite(this.repository);

  Future<void> call(int articleId) async {
    return await repository.toggleFavorite(articleId);
  }
}