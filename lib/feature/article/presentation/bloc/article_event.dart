part of 'article_bloc.dart';

abstract class ArticleEvent extends Equatable {
  const ArticleEvent();

  @override
  List<Object> get props => [];
}

class FetchArticles extends ArticleEvent {}

class ToggleFavoriteEvent extends ArticleEvent {
  final int articleId;

  const ToggleFavoriteEvent(this.articleId);

  @override
  List<Object> get props => [articleId];
}