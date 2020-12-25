import 'package:ReadHeadlines/commonwidgets/drawerdash.dart';
import 'package:flutter/material.dart';
import 'package:ReadHeadlines/newsscreens/commonRSStype.dart';

class WorldNews extends StatefulWidget {
  @override
  _WorldNewsState createState() => _WorldNewsState();
}

class _WorldNewsState extends State<WorldNews> {
  static const String title = 'Headlines';
  final changer = 'headlines';
  static const List rsscommonlinks = [
    'https://deployment-fmb.herokuapp.com/feeds?link=http://feeds.bbci.co.uk/news/world/rss.xml',
    'https://deployment-fmb.herokuapp.com/feeds?link=https://www.nytimes.com/svc/collections/v1/publish/https://www.nytimes.com/section/world/rss.xml',
    'https://deployment-fmb.herokuapp.com/feeds?link=https://www.yahoo.com/news/rss/world',
    'https://deployment-fmb.herokuapp.com/feeds?link=https://www.theguardian.com/world/rss',
    'https://deployment-fmb.herokuapp.com/feeds?link=http://rss.cnn.com/rss/edition_world.rss',
    'https://deployment-fmb.herokuapp.com/feeds?link=https://newslanes.com/feed/',
  ];

  final bbc = rsscommonlinks[0];
  final nytimes = rsscommonlinks[1];
  final yahoo = rsscommonlinks[2];
  final guardian = rsscommonlinks[3];
  final cnn = rsscommonlinks[4];
  final newslane = rsscommonlinks[5];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      initialIndex: 0,
      child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 200,
            title: Container(child: Image.asset('assets/Pg3/RHlogo.png', width: MediaQuery.of(context).size.width*.3,)),
            centerTitle: true,
            bottom: TabBar(
              isScrollable: true,
              tabs: <Widget>[
                Tab(
                  text: 'BBC',
                ),
                Tab(
                  text: 'CNN',
                ),
                Tab(
                  text: 'The Guardian',
                ),
                Tab(
                  text: 'Yahoo',
                  // child: Text('boy', style: TextStyle(color: Colors.black,)),
                ),
                Tab(
                  text: 'New York Times',
                ),
                Tab(
                  text: 'Newslanes',
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              RSScommon(url: bbc),
              RSScommon(url: cnn),
              RSScommon(url: guardian),
              RSScommon(url: yahoo),
              RSScommon(url: nytimes),
              RSScommon(url: newslane)
            ],
          ),
          drawer: DrawerDash(titletext: title)),
    );
  }
}
