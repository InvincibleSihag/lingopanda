import 'dart:developer';

import 'package:lingopanda/core/constants/constants.dart';
import 'package:lingopanda/core/constants/error_messages.dart';
import 'package:lingopanda/core/network/connection_checker.dart';
import 'package:lingopanda/features/news/data/models/news_server_model.dart';
import 'package:dio/dio.dart';
import 'package:lingopanda/init_dependencies.dart';

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
    if(!await serviceLocator<ConnectionChecker>().isConnected){
      throw Exception('No internet connection');
    }
    // log("country: $country");
    try{
    final response = await dio.get(
        apiUrl,
        queryParameters: {
          'country': country,
          'apiKey': apiKey,
          'page': page,
          'pageSize': limit,
        },
      );
      // log(response.realUri.toString());
      // log("page: $page , limit: $limit");
      // log(response.data.toString());
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['articles'];
        // log(data.toString());
        List<NewsServerModel> news = [];
        news = data
            .map((article) => NewsServerModel(
                  title: article['title'] ?? '',
                  description: article['description'] ?? '',
                  imageUrl: article['urlToImage'] ?? '',
                  date: article['publishedAt'] ?? '',
                  url: article['url'] ?? '',
                  id: article['id'] ?? '${article['title']}_${article['description']}'.hashCode.toString(),
                ))
            .toList();
        for (NewsServerModel ne in news) {
          // log(ne.toString());
          // log("\n");
        }
        return news;
      }
      else if(response.statusCode == 429){
        throw Exception("${ErrorMessages.newsFetchError} Api limit reached");
      }
      else {
        throw Exception("${ErrorMessages.newsFetchError}status code: ${response.statusCode}");
      }
      }catch(e, stackTrace){
        log(e.toString(), stackTrace: stackTrace);
        throw Exception(ErrorMessages.newsFetchError);
      }
  }
}
