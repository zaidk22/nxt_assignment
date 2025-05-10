import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nxt_assignment/core/widgets/app_error_widget.dart';
import 'package:nxt_assignment/core/widgets/app_loading_indicator.dart';

import '../bloc/article_bloc.dart';
import 'article_detail_screen.dart';
import 'favorites_screen.dart';
import 'search_delegate.dart';

class ArticlesScreen extends StatelessWidget {
  const ArticlesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Articles'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: ArticleSearchDelegate(
                  articles: context.read<ArticleBloc>().state is ArticleLoaded
                      ? (context.read<ArticleBloc>().state as ArticleLoaded).articles
                      : [],
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FavoritesScreen(),
                ),
              );
            },
          ),
        ],
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
            return RefreshIndicator(
              onRefresh: () async {
                context.read<ArticleBloc>().add(FetchArticles());
              },
              child: ListView.builder(
                itemCount: state.articles.length,
                itemBuilder: (context, index) {
                  final article = state.articles[index];
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
                        icon: Icon(
                          article.isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: article.isFavorite ? Colors.red : null,
                        ),
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
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}