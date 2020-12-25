import 'package:ReadHeadlines/commonwidgets/drawerdash.dart';
import 'package:ReadHeadlines/newsscreens/commonRSStype.dart';
import 'package:flutter/material.dart';
import 'package:ReadHeadlines/newsscreens/washington.dart';

class Soccer extends StatefulWidget {
  @override
  _SoccerState createState() => _SoccerState();
}

class _SoccerState extends State<Soccer> {
  static const String titletext = 'Sports';
  static const List links = [
    'https://deployment-fmb.herokuapp.com/feeds?link=https://www.espn.com/espn/rss/soccer/news',
  ];
  final espn = links[0];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
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
                text: 'ESPN',
              ),
              Tab(
                text: 'Goal',
              ),
              Tab(
                text: 'Yahoo',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            RSScommon(url: espn),
            WashingtonPosts(),
            WashingtonPosts(),
          ],
        ),
        drawer: DrawerDash(
          titletext: titletext,
        ),
      ),
    );
  }
}
