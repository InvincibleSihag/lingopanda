import 'package:flutter/material.dart';
import 'package:lingopanda/config/color_pallate.dart';
import 'package:lingopanda/core/constants/constants.dart';
import 'package:lingopanda/core/utilities/utils.dart';
import 'package:lingopanda/features/news/domain/entities/news_model.dart';

class NewsCard extends StatelessWidget {
  final NewsModel news;

  const NewsCard({
    super.key,
    required this.news,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.circular(DisplayConstants.generalBorderRadius),
        color: ColorPalette.appWhite,
      ),
      margin: const EdgeInsets.all(DisplayConstants.smallPadding),
      child: Padding(
        padding: const EdgeInsets.all(DisplayConstants.generalPadding),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    news.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: DisplayConstants.generalFontSize,
                    ),
                  ),
                  const SizedBox(height: DisplayConstants.smallPadding),
                  Text(
                    maxLines: 3,
                    news.description,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: DisplayConstants.smallFontSize,
                    ),
                  ),
                  const SizedBox(height: DisplayConstants.smallPadding),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      getDateFormattedText(DateTime.parse(news.date)),
                      style: const TextStyle(
                        color: ColorPalette.appGrey,
                        fontSize: DisplayConstants.smallFontSize - 2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: DisplayConstants.generalPadding),
            Container(
              clipBehavior: Clip.hardEdge,
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(DisplayConstants.generalBorderRadius),
              ),
              child: Image.network(
                news.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    "assets/images/news_image_placeholder.jpeg",
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
