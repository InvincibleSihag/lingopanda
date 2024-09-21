import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lingopanda/config/color_pallate.dart';
import 'package:lingopanda/core/constants/constants.dart';
import 'package:lingopanda/core/constants/placeholder_descriptions.dart';
import 'package:lingopanda/core/utilities/snackbar.dart';
import 'package:lingopanda/features/auth/presentation/pages/login_page.dart';
import 'package:lingopanda/features/news/presentation/widgets/news_card.dart';
import 'package:lingopanda/init_dependencies.dart';
import 'package:lingopanda/services/remote_config.dart';
import 'package:provider/provider.dart';
import 'package:lingopanda/features/news/presentation/providers/news_provider.dart';

class NewsPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const NewsPage());
  const NewsPage({super.key});

  @override
  NewsPageState createState() => NewsPageState();
}

class NewsPageState extends State<NewsPage> {
  late ScrollController _scrollController;
  late NewsProvider _newsProvider;

  @override
  void initState() {
    super.initState();
    _newsProvider = serviceLocator<NewsProvider>();
    _newsProvider.setOnErrorCallback(_showErrorSnackbar);
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  void _showErrorSnackbar(String message) {
    showSnackBar(context, message);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !_newsProvider.isLoading &&
        _newsProvider.hasMore) {
      // log("fetching news");
      _newsProvider.fetchNews();
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  Widget _buildNewsList() {
    return Consumer<NewsProvider>(
      builder: (context, provider, child) {
        if (provider.news.isEmpty) {
          if (provider.isLoading) {
            return const Center(
                child: CupertinoActivityIndicator(
              color: ColorPalette.secondary,
            ));
          } else {
            return const Center(
                child: Text(
              'No news available.',
              style: TextStyle(
                  fontSize: DisplayConstants.generalFontSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.red),
            ));
          }
        }

        return ListView.builder(
          shrinkWrap: true,
          primary: false,
          itemCount: provider.hasMore
              ? provider.news.length + 1
              : provider.news.length,
          itemBuilder: (context, index) {
            if (index < provider.news.length) {
              final newsItem = provider.news[index];
              return NewsCard(news: newsItem);
            } else {
              return const Padding(
                padding: EdgeInsets.symmetric(
                    vertical: DisplayConstants.generalPadding),
                child: Center(
                    child: CupertinoActivityIndicator(
                  color: ColorPalette.secondary,
                )),
              );
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          PlaceholderDescriptions.appName,
          style: TextStyle(
              color: ColorPalette.appWhite,
              fontSize: DisplayConstants.generalFontSize,
              fontWeight: FontWeight.bold),
        ),
        actions: [
          const Icon(CupertinoIcons.location_fill,
              color: ColorPalette.appWhite),
          const SizedBox(width: DisplayConstants.generalPadding),
          Text(
            serviceLocator<RemoteConfigService>()
                .getRemoteConfigValue(countryKey)
                .toUpperCase(),
            style: const TextStyle(
                fontSize: DisplayConstants.generalFontSize,
                fontWeight: FontWeight.bold,
                color: ColorPalette.appWhite),
          ),
          const SizedBox(width: DisplayConstants.generalPadding),
          IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushAndRemoveUntil(
                    context, LoginScreen.route(), (route) => false);
              },
              icon: const Icon(
                Icons.logout,
                color: ColorPalette.appWhite,
              )),
          const SizedBox(width: DisplayConstants.generalPadding),
        ],
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Padding(
          padding: const EdgeInsets.all(DisplayConstants.generalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Top Headlines',
                  style: TextStyle(
                    fontSize: DisplayConstants.generalFontSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: DisplayConstants.generalPadding),
              _buildNewsList(),
            ],
          ),
        ),
      ),
    );
  }
}
