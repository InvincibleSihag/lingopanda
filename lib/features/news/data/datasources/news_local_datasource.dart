import 'package:hive_flutter/hive_flutter.dart';
import 'package:lingopanda/core/constants/constants.dart';
import 'package:lingopanda/features/news/data/models/news_server_model.dart';

abstract class NewsLocalDataSource {
  Future<void> saveNews(List<NewsServerModel> news);
  List<NewsServerModel> getNews();
}

class NewsLocalDataSourceImpl implements NewsLocalDataSource {
  final Box<NewsServerModel> newsBox =
      Hive.box<NewsServerModel>(HiveConstants.newsBox);

  @override
  Future<void> saveNews(List<NewsServerModel> news) async {
    Map<String, NewsServerModel> newsMap = {};
    for (var e in news) {
      newsMap[e.id] = e;
    }
    await newsBox.putAll(newsMap);
  }

  @override
  List<NewsServerModel> getNews() {
    return newsBox.values.toList();
  }
}
