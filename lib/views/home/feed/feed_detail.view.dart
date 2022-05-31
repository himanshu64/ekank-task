import 'dart:ui';

import 'package:ekank/models/article_model.dart';
import 'package:ekank/viewmodels/feed.viewmodel.dart';
import 'package:ekank/views/widgets/bookmark_icon.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:intl/intl.dart';

class FeedDetailView extends GetView<FeedViewModel> {
  static const routeName = '/articleDetail';
  final Article article;
  final int index;
  const FeedDetailView({Key? key, required this.article, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalKey _containerKey = GlobalKey();
    return Scaffold(
      appBar: AppBar(
        actions: [
          BookmarkIcon(
            article: article,
            isDark: true,
          )
        ],
      ),
      body: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
            minWidth: double.maxFinite,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(width: 0.3),
          ),
          child: RepaintBoundary(
            key: _containerKey,
            child: Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  FractionallySizedBox(
                    alignment: Alignment.topCenter,
                    heightFactor: 0.4,
                    child: Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        article.urlToImage != null
                            ? Container(
                                decoration: BoxDecoration(
                                  // color: AppColor.surface,
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      article.urlToImage!,
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                            : Container(
                                // color: AppColor.surface,
                                ),
                        Positioned(
                          top: 0,
                          left: 0,
                          height: double.maxFinite,
                          width: double.maxFinite,
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: Container(
                              color: Colors.black.withOpacity(0.8),
                            ),
                          ),
                        ),
                        article.urlToImage != null
                            ? GestureDetector(
                                // onTap: () => Router.navigator.pushNamed(
                                //   Router.expandedImageView,
                                //   arguments: ExpandedImageViewArguments(
                                //     image: article.urlToImage,
                                //   ),
                                // ),
                                child: Center(
                                  child: ExtendedImage.network(
                                    article.urlToImage!,
                                    fit: BoxFit.cover,
                                    alignment: Alignment.topCenter,
                                  ),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                  FractionallySizedBox(
                    alignment: Alignment.bottomCenter,
                    heightFactor: 0.6,
                    child: Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        FractionallySizedBox(
                          alignment: Alignment.topCenter,
                          heightFactor: 0.85,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(16, 25, 16, 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: [
                                    Flexible(
                                      child: Text(
                                        article.title!,
                                        style: const TextStyle(
                                          // color: AppColor.onBackground,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 4,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  article.description ?? "",
                                  // style: AppTextStyle.newsSubtitle,
                                  overflow: TextOverflow.fade,
                                  maxLines: 9,
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Text(
                                  " ${article.author} / ${DateFormat("MMMM d").format(
                                    DateTime.parse(article.publishedAt!),
                                  )}",
                                  // style: AppTextStyle.newsFooter,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
