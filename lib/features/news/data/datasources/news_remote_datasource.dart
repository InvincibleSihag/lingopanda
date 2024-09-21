import 'dart:developer';

import 'package:lingopanda/features/news/data/models/news_server_model.dart';
import 'package:dio/dio.dart';

abstract class NewsRemoteDataSource {
  Future<List<NewsServerModel>> getNews(
      {required int limit, required int page});
}

class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  final Dio dio;
  final String apiKey;
  final String country;

  NewsRemoteDataSourceImpl({
    required this.dio,
    required this.apiKey,
    required this.country,
  });

  @override
  Future<List<NewsServerModel>> getNews(
      {required int limit, required int page}) async {
    log("country: $country");
    final response = await dio.get(
      'https://newsapi.org/v2/top-headlines',
      queryParameters: {
        'country': country,
        'apiKey': apiKey,
        'page': page,
        'pageSize': limit,
      },
    );
    // log(response.data.toString());
    if (response.statusCode == 200) {
      final List<dynamic> data = response.data['articles'];
      // log(data.toString());
      List<NewsServerModel> news = [];
      news = data
          .map((article) => NewsServerModel(
                title: article['title'] ?? 'No Title',
                description: article['description'] ?? 'No Description',
                imageUrl: article['urlToImage'] ?? '',
                date: article['publishedAt'] ?? '',
                url: article['url'] ?? '',
              ))
          .toList();
      for (NewsServerModel ne in news) {
        log(ne.toString());
        log("\n");
      }
      return news;
    } else {
      throw Exception('Failed to load news');
    }
  }
}
