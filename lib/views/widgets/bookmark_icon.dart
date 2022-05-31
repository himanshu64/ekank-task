import 'package:ekank/models/article_model.dart';
import 'package:ekank/viewmodels/feed.viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get_state_manager/get_state_manager.dart';

class BookmarkIcon extends StatelessWidget {
  final Article article;
  final bool isDark;
  const BookmarkIcon({Key? key, required this.article, this.isDark = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FeedViewModel>(
        init: FeedViewModel(),
        id: "bookmark_icon",
        builder: (controller) => FutureBuilder(
              future: controller.checkByTitle(article.title ?? ''),
              builder: ((context, AsyncSnapshot<bool> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container();
                } else {
                  if (snapshot.hasData) {
                    print("data " + snapshot.data.toString());
                    article.isBookmarked = snapshot.data!;
                    return IconButton(
                      onPressed: () {
                        if (snapshot.data!) {
                          controller.removeBookmark(article.title ?? '');
                        } else {
                          controller.addBookmark(article);
                        }
                      },
                      iconSize: 30.0,
                      icon: Icon(
                        article.isBookmarked
                            ? CupertinoIcons.heart_solid
                            : CupertinoIcons.heart,
                        color: article.isBookmarked
                            ? Colors.red
                            : !isDark
                                ? Colors.black
                                : Colors.white,
                      ),
                    );
                  }
                }
                return Container();
              }),
            ));
  }
}
