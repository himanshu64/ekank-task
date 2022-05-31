import 'package:ekank/helpers/enums.dart';
import 'package:ekank/viewmodels/feed.viewmodel.dart';
import 'package:ekank/views/home/feed/feed_detail.view.dart';
import 'package:ekank/views/widgets/article_item.dart';
import 'package:ekank/views/widgets/articles_list_view_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeedBookmarkView extends GetView<FeedViewModel> {
  const FeedBookmarkView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => RefreshIndicator(
        onRefresh: () async {
          // controller.refresh();
        },
        child: controller.bookmark.isEmpty && controller.state == ViewState.busy
            ? const ArticlesListViewShimmer()
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: controller.bookmark.length,
                      itemBuilder: (context, int index) {
                        return ArticlesListViewItem(
                          data: controller.bookmark[index],
                          onPressed: () {
                            Get.to(() => FeedDetailView(
                                  article: controller.bookmark[index],
                                  index: index,
                                ));
                          },
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
