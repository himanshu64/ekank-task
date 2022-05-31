import 'package:ekank/views/home/feed/feed.view.dart';
import 'package:ekank/views/home/feed/feed_bookmark.view.dart';
import 'package:ekank/views/widgets/signout_widget.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  static const routeName = '/home';

  HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Firebase App'),
          actions: const [SignOutWidget()],
          bottom: const TabBar(
            tabs: [
              Tab(
                child: Text('News Feed'),
              ),
              Tab(
                child: Text('Saved News'),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            FeedView(),
            FeedBookmarkView(),
          ],
        ),
      ),
    );
  }
}
