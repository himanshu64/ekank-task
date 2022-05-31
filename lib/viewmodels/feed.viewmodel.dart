import 'dart:async';

import 'package:ekank/helpers/db_helper.dart';
import 'package:ekank/helpers/enums.dart';
import 'package:ekank/helpers/http_helpers/network_exceptions.dart';
import 'package:ekank/models/article_model.dart';
import 'package:ekank/services/api/feed.service.dart';
import 'package:ekank/viewmodels/base.viewmodel.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class FeedViewModel extends BaseViewModel {
  final FeedService _feedService = Get.find<FeedService>();

  final ScrollController scrollController = ScrollController();
  var articles = <Article>[].obs;
  var bookmark = <Article>[].obs;
  int _page = 1;

  @override
  void onReady() {
    fetchArticles();
    fetchBookmarkedArticles();

    scrollController.addListener(() async {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        if (state == ViewState.idle) {
          await nextPage();
        }
      }
    });
    super.onReady();
  }

  fetchBookmarkedArticles() async {
    setState(ViewState.busy);
    List<Map<String, dynamic>> bookArticles = await DBHelper().queryAllRows();

    bookmark.value = bookArticles.map((e) => Article.fromJson(e)).toList();
    setState(ViewState.idle);
  }

  Future<void> refresh() async {
    articles.clear();

    fetchArticles(page: 1);
  }

  void fetchArticles({int page = 1}) async {
    setState(ViewState.busy);
    var response = await _feedService.fetchFeedContent(page: page);
    response.when(success: (List<Article> articleList) {
      if (articleList.isEmpty) {
        Fluttertoast.showToast(
            msg: "No more item!", toastLength: Toast.LENGTH_LONG, fontSize: 16);
      }
      _page = page;
      if (articles.isNotEmpty) {
        articles.addAll(articleList);
      } else {
        articles.value = articleList;
      }

      setState(ViewState.idle);
    }, failure: (NetworkExceptions? failure) {
      setState(ViewState.idle);

      var error = NetworkExceptions.getErrorMessage(failure!);
      print(error);
      if (error["resultValue"] != null) {
        Fluttertoast.showToast(
            msg: error["resultValue"]["message"],
            toastLength: Toast.LENGTH_LONG,
            fontSize: 16);
      } else {
        Fluttertoast.showToast(
            msg: error["errorMessage"],
            toastLength: Toast.LENGTH_LONG,
            fontSize: 16);
      }
    });
  }

  Future<void> nextPage() async {
    fetchArticles(page: _page + 1);
  }

  void updateBookmark(int index) {
    // if (articles.value.isNotEmpty) {
    //   articles.value[index].isBookmarked = !articles.value[index].isBookmarked;
    // }
  }

  Future<bool> checkByTitle(String title) async {
    Completer<bool> _completer = Completer<bool>();

    List<Map<String, dynamic>> data = await DBHelper().checkByTitle(title);

    if (data.isNotEmpty) {
      _completer.complete(true);
    } else {
      _completer.complete(false);
    }
    return _completer.future;
  }

  void addBookmark(Article article) async {
    try {
      await DBHelper().insertTask(article);

      Fluttertoast.showToast(
          msg: "Bookmark Added", toastLength: Toast.LENGTH_SHORT, fontSize: 16);
      update(['bookmark_icon']);
    } catch (e) {
      print(e);
    }
    fetchBookmarkedArticles();
  }

  void removeBookmark(String title) async {
    int value = await DBHelper().deleteByTitle(title);
    if (value == 1) {
      Fluttertoast.showToast(
          msg: "Bookmark removed",
          toastLength: Toast.LENGTH_SHORT,
          fontSize: 16);
    }
    update(['bookmark_icon']);
    fetchBookmarkedArticles();
  }
}
