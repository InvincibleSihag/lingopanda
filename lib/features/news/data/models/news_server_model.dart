
import 'package:lingopanda/features/news/domain/entities/news_model.dart';

class NewsServerModel extends NewsModel {

  NewsServerModel({
    required super.title,
    required super.description,
    required super.imageUrl,
    required super.date,
    required super.url,
  });

  factory NewsServerModel.fromJson(Map<String, dynamic> json) {
    return NewsServerModel(
      title: json['title'] ?? 'No Title',
      description: json['description'] ?? 'No Description',
      imageUrl: json['urlToImage'] ?? '',
      date: json['publishedAt'] ?? '',
      url: json['url'] ?? '',
    );
  }

  @override
  String toString() {
    return 'NewsServerModel(title: $title, description: $description, imageUrl: $imageUrl, date: $date, url: $url)';
  }
}

