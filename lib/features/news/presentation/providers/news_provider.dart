import 'package:flutter/material.dart';
import 'package:lingopanda/features/news/domain/entities/news_model.dart';
import 'package:lingopanda/features/news/domain/repository/news_repository.dart';

class NewsProvider with ChangeNotifier {
  final List<NewsModel> _news = [];
  List<NewsModel> get news => _news;

  final NewsRepository _newsRepository;
  final int _limit = 10;
  int _page = 0;
  bool _isLoading = false;
  bool _hasMore = true;

  NewsProvider(this._newsRepository) {
    fetchNews();
  }

  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;

  Future<void> fetchNews() async {
    if (_isLoading || !_hasMore) return;

    _isLoading = true;
    notifyListeners();

    final result = await _newsRepository.getNews(limit: _limit, page: _page);
    result.fold(
      (failure) {
        // Handle failure (e.g., show a snackbar)
        _isLoading = false;
        notifyListeners();
      },
      (newsList) {
        if (newsList.length < _limit) {
          _hasMore = false;
        }
        _news.addAll(newsList);
        _page++;
        _isLoading = false;
        notifyListeners();
      },
    );
  }
}
