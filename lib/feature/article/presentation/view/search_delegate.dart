import 'package:flutter/material.dart';

import '../../data/models/article_model.dart';
import 'article_detail_screen.dart';

class ArticleSearchDelegate extends SearchDelegate {
  final List<ArticleModel> articles;

  ArticleSearchDelegate({required this.articles});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = articles.where((article) =>
        article.title.toLowerCase().contains(query.toLowerCase()) ||
        article.body.toLowerCase().contains(query.toLowerCase())).toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final article = results[index];
        return ListTile(
          title: Text(article.title),
          subtitle: Text(article.body),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ArticleDetailScreen(article: article),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = query.isEmpty
        ? <ArticleModel>[]
        : articles.where((article) =>
            article.title.toLowerCase().contains(query.toLowerCase()) ||
            article.body.toLowerCase().contains(query.toLowerCase())).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final article = suggestions[index];
        return ListTile(
          title: Text(article.title),
          subtitle: Text(article.body),
          onTap: () {
            query = article.title;
            showResults(context);
          },
        );
      },
    );
  }
}