import 'package:hive_flutter/hive_flutter.dart';
import 'package:lingopanda/features/news/domain/entities/news_model.dart';

part 'news_server_model.g.dart';

@HiveType(typeId: 1)
class NewsServerModel extends NewsModel {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String description;
  @HiveField(2)
  final String imageUrl;
  @HiveField(3)
  final String date;
  @HiveField(4)
  final String url;
  @HiveField(5)
  final String id;

  NewsServerModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.date,
    required this.url,
  }) : super(
          title: title,
          description: description,
          imageUrl: imageUrl,
          date: date,
          url: url,
        );

  factory NewsServerModel.fromJson(Map<String, dynamic> json) {
    return NewsServerModel(
      title: json['title'] ?? 'No Title',
      description: json['description'] ?? 'No Description',
      imageUrl: json['urlToImage'] ?? '',
      date: json['publishedAt'] ?? '',
      url: json['url'] ?? '', id: json['id'] ?? '',
    );
  }

  @override
  String toString() {
    return 'NewsServerModel(title: $title, description: $description, imageUrl: $imageUrl, date: $date, url: $url)';
  }
}

