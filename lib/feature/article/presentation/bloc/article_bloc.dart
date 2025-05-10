
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/article_model.dart';
import '../../domain/usecases/get_articles.dart';
import '../../domain/usecases/toggle_favorite.dart';


part 'article_event.dart';
part 'article_state.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final GetArticles getArticles;
  final ToggleFavorite toggleFavorite;

  ArticleBloc({
    required this.getArticles,
    required this.toggleFavorite,
  }) : super(ArticleInitial()) {
    on<FetchArticles>(_onFetchArticles);
    on<ToggleFavoriteEvent>(_onToggleFavorite);
  }

  Future<void> _onFetchArticles(
    FetchArticles event,
    Emitter<ArticleState> emit,
  ) async {
    emit(ArticleLoading());
    final failureOrArticles = await getArticles();
    failureOrArticles.fold(
      (failure) => emit(ArticleError(message: failure.message)),
      (articles) => emit(ArticleLoaded(articles: articles)),
    );
  }

  Future<void> _onToggleFavorite(
    ToggleFavoriteEvent event,
    Emitter<ArticleState> emit,
  ) async {
    if (state is ArticleLoaded) {
      await toggleFavorite(event.articleId);
      final currentState = state as ArticleLoaded;
      final updatedArticles = currentState.articles.map((article) {
        return article.id == event.articleId
            ? article.copyWith(isFavorite: !article.isFavorite)
            : article;
      }).toList();
      emit(ArticleLoaded(articles: updatedArticles));
    }
  }
}