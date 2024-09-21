import 'dart:developer';

import 'package:fpdart/fpdart.dart';
import 'package:lingopanda/core/error/failures.dart';
import 'package:lingopanda/features/news/data/datasources/news_remote_datasource.dart';
import 'package:lingopanda/features/news/domain/entities/news_model.dart';
import 'package:lingopanda/features/news/domain/repository/news_repository.dart';


class NewsRepositoryImpl implements NewsRepository {
  final NewsRemoteDataSource newsRemoteDataSource;

  NewsRepositoryImpl({required this.newsRemoteDataSource});

  @override
  Future<Either<Failure, List<NewsModel>>> getNews({required int limit, required int page}) async {
    try {
      final news = await newsRemoteDataSource.getNews(limit: limit, page: page);
      return right(news);
    } catch (e, stackTrace) {
      log('Error fetching news: $e', stackTrace: stackTrace);
      return left(Failure(e.toString()));
    }
  }
}
  