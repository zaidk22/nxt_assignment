import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:nxt_assignment/core/widgets/app_error_widget.dart';
import 'package:nxt_assignment/core/widgets/app_loading_indicator.dart';

import '../bloc/article_bloc.dart';
import 'article_detail_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Articles'),
      ),
      body: BlocBuilder<ArticleBloc, ArticleState>(
        builder: (context, state) {
          if (state is ArticleLoading) {
            return const AppLoadingIndicator();
          } else if (state is ArticleError) {
            return AppErrorWidget(
              message: state.message,
              onRetry: () => context.read<ArticleBloc>().add(FetchArticles()),
            );
          } else if (state is ArticleLoaded) {
            final favoriteArticles = state.articles.where((a) => a.isFavorite).toList();
            
            if (favoriteArticles.isEmpty) {
              return const Center(
                child: Text('No favorite articles yet'),
              );
            }

            return ListView.builder(
              itemCount: favoriteArticles.length,
              itemBuilder: (context, index) {
                final article = favoriteArticles[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    title: Text(article.title),
                    subtitle: Text(
                      article.body,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.favorite, color: Colors.red),
                      onPressed: () {
                        context.read<ArticleBloc>().add(
                              ToggleFavoriteEvent(article.id),
                            );
                      },
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ArticleDetailScreen(article: article),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}