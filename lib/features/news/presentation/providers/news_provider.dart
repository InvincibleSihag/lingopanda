import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lingopanda/features/news/domain/entities/news_model.dart';
import 'package:lingopanda/features/news/domain/repository/news_repository.dart';

class NewsProvider with ChangeNotifier {
  final List<NewsModel> _news = [];
  List<NewsModel> get news => _news;

  // StreamSubscription<Either<Failure, List<NewsModel>>>? streamSubscription;

  final NewsRepository _newsRepository;
  final int _limit = 10;
  int _page = 0;
  bool _isLoading = false;
  bool _hasMore = true;
  void Function(String)? _onError;

  NewsProvider(this._newsRepository) {
    fetchNews();
  }

  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;

  void setOnErrorCallback(void Function(String) onError) {
    _onError = onError;
  }

  Future<void> fetchNews() async {
    if (_isLoading || !_hasMore) return;

    _isLoading = true;
    notifyListeners();

    _newsRepository.getNews(limit: _limit, page: _page).listen((result) {
      result.fold(
        (failure) {
          _isLoading = false;
          notifyListeners();
          _onError?.call(failure.message);
        },
        (newsList) {
          if (newsList.length < _limit) {
            _hasMore = false;
          }
          _news.addAll(newsList.where((element) => (element.title.isNotEmpty && element.description.isNotEmpty && element.title.trim().toLowerCase() != "[removed]")));
          _page++;
          _isLoading = false;
          notifyListeners();
        },
      );
    });
  }

  // void onDispose() {
  //   if (streamSubscription != null) {
  //     streamSubscription!.cancel();
  //   }
  //   super.dispose();
  // }
}
