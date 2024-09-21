import 'package:flutter/material.dart';
import 'package:lingopanda/config/color_pallate.dart';
import 'package:lingopanda/core/utilities/utils.dart';
import 'package:lingopanda/init_dependencies.dart';
import 'package:lingopanda/services/remote_config.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
    _newsProvider = Provider.of<NewsProvider>(context, listen: false);
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !_newsProvider.isLoading &&
        _newsProvider.hasMore) {
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
            return const Center(child: CircularProgressIndicator());
          } else {
            return const Center(child: Text('No news available.'));
          }
        }

        return ListView.builder(
          controller: _scrollController,
          itemCount: provider.hasMore
              ? provider.news.length + 1
              : provider.news.length,
          itemBuilder: (context, index) {
            if (index < provider.news.length) {
              final newsItem = provider.news[index];
              return ListTile(
                leading: CachedNetworkImage(
                  height: 300,
                  width: 100,
                  fit: BoxFit.cover,
                  imageUrl: newsItem.imageUrl,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                title: Text(newsItem.title),
                subtitle: Text(newsItem.description),
                trailing:
                    Text(getDateFormattedText(DateTime.parse(newsItem.date))),
              );
            } else {
              // Display loading indicator at the bottom
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Center(child: CircularProgressIndicator()),
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
          'MyNews',
          style: TextStyle(
              color: ColorPalette.appWhite,
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
        actions: [
          const Padding(
            padding: EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
            child: Icon(
              Icons.navigation_rounded,
              color: ColorPalette.appWhite,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, right: 16.0),
            child: Text(
              serviceLocator<RemoteConfigService>()
                  .getRemoteConfigValue("country"),
              style: const TextStyle(
                  color: ColorPalette.appWhite, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      body: _buildNewsList(),
    );
  }
}
