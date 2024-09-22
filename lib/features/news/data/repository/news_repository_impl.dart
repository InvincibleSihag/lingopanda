import 'dart:developer';

import 'package:fpdart/fpdart.dart';
import 'package:lingopanda/core/error/failures.dart';
import 'package:lingopanda/features/news/data/datasources/news_local_datasource.dart';
import 'package:lingopanda/features/news/data/datasources/news_remote_datasource.dart';
import 'package:lingopanda/features/news/domain/entities/news_model.dart';
import 'package:lingopanda/features/news/domain/repository/news_repository.dart';

class NewsRepositoryImpl implements NewsRepository {
  bool fetchedNews = false;
  final NewsRemoteDataSource newsRemoteDataSource;
  final NewsLocalDataSource newsLocalDataSource;

  NewsRepositoryImpl({
    required this.newsRemoteDataSource,
    required this.newsLocalDataSource,
  });

  @override
  Stream<Either<Failure, List<NewsModel>>> getNews(
      {required int limit, required int page}) async* {
    try {
      final news = await newsRemoteDataSource.getNews(limit: limit, page: page);
      newsLocalDataSource.saveNews(news);
      fetchedNews = true;
      yield right(news);
      log("News fetched from remote $page");
      return;
    } catch (e) {
      final localNews = newsLocalDataSource.getNews();
      if (localNews.isNotEmpty) {
        if(!fetchedNews){
          fetchedNews = true;
          yield left(Failure("Getting Cached News : $e"));
          yield right(localNews);
          return;
        }
        yield left(Failure(e.toString()));
        return;
      } else {
        yield left(Failure(e.toString()));
        return;
      }
    }
  }
}
