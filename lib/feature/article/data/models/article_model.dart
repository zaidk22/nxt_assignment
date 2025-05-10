import 'package:hive/hive.dart';

part 'article_model.g.dart';

@HiveType(typeId: 0)
class ArticleModel {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String body;
  @HiveField(3)
  final bool isFavorite;

  ArticleModel({
    required this.id,
    required this.title,
    required this.body,
    this.isFavorite = false,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }

  ArticleModel copyWith({
    int? id,
    String? title,
    String? body,
    bool? isFavorite,
  }) {
    return ArticleModel(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}