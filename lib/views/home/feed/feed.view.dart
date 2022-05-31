import 'package:ekank/helpers/enums.dart';
import 'package:ekank/viewmodels/feed.viewmodel.dart';
import 'package:ekank/views/home/feed/feed_detail.view.dart';
import 'package:ekank/views/widgets/article_item.dart';
import 'package:ekank/views/widgets/articles_list_view_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class FeedView extends GetView<FeedViewModel> {
  const FeedView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => RefreshIndicator(
          onRefresh: () async {
            controller.refresh();
          },
          child:
              controller.articles.isEmpty && controller.state == ViewState.busy
                  ? const ArticlesListViewShimmer()
                  : Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            controller: controller.scrollController,
                            itemCount: controller.articles.length,
                            itemBuilder: (context, int index) {
                              return ArticlesListViewItem(
                                data: controller.articles[index],
                                onPressed: () {
                                  Get.to(() => FeedDetailView(
                                        article: controller.articles[index],
                                        index: index,
                                      ));
                                },
                              );
                            },
                          ),
                        ),
                        controller.state == ViewState.busy
                            ? const SizedBox(
                                child: LinearProgressIndicator(
                                  minHeight: 10,
                                  color: Colors.blue,
                                ),
                              )
                            : Container()
                      ],
                    ),
        ));
  }
}
