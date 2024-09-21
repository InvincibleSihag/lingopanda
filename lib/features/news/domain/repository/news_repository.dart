import 'package:fpdart/fpdart.dart';
import 'package:lingopanda/core/error/failures.dart';
import 'package:lingopanda/features/news/domain/entities/news_model.dart';

abstract class NewsRepository {
  Stream<Either<Failure, List<NewsModel>>> getNews({required int limit, required int page});
}

