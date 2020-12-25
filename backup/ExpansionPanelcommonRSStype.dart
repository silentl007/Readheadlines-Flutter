// import 'package:ReadHeadlines/commonwidgets/subtitle.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animations/loading_animations.dart';
import 'dart:async';
import 'dart:convert';
import 'package:ReadHeadlines/commonwidgets/webview.dart';

class RSScommon extends StatefulWidget {
  final String url;
  RSScommon({this.url});
  @override
  _RSScommonState createState() => _RSScommonState(this.url);
}

class _RSScommonState extends State<RSScommon> {
  final String _resolve;
  _RSScommonState(this._resolve);
  List<ParsedData> feeddata = [];
  Future<List> _feedprocess() async {
    try {
      var feed = await http.get(_resolve);
      var jsonData = jsonDecode(feed.body);
      if (jsonData != null) {
        for (var info in jsonData) {
          ParsedData parsed = ParsedData(
              title: info["title"],
              published: info['published'],
              link: info['link'],
              summary: info['summary'],
              isExpanded: false);
          feeddata.add(parsed);
        }
      }
      return feeddata;
    } catch (e) {
      List feeddata = ['failed'];
      return feeddata;
    }
  }

  void _reset() {
    // reset function for no internet
    setState(() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          LoadingBouncingGrid.square(), // loading animation for fetching data
          Text('Fetching Data')
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: _feedprocess(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData == false) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                LoadingBouncingGrid
                    .square(), // loading animation for fetching data
                Text('Fetching Data')
              ],
            );
          } else if (snapshot.data[0] == 'failed') {
            return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('No Internet Connection'), // reset button if no internet
                  RaisedButton(child: Text('Retry'), onPressed: _reset),
                ]);
          }
          return Container(
            child: ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return ExpansionTile(
                  title: Text(snapshot.data[index].title),
                  leading: Icon(Icons.arrow_right),
                  children: <Widget>[
                    Row(
                      children: [
                        IconButton(
                            icon: Icon(Icons.open_in_full),
                            onPressed: () => webviewcaller(
                                context, snapshot.data[index].link)),
                        IconButton(icon: Icon(Icons.share), onPressed: null)
                      ],
                    )
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }

  void webviewcaller(BuildContext context, String url) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => WebViewPage(url)));
  }

  summaryDialog(BuildContext context, String summary, String link) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Summary'),
            content: Text(summary ??= 'Sorry, no summary available'),
            actions: [
              FlatButton(
                  onPressed: () => webviewcaller(context, link),
                  child: Text('Open')),
              FlatButton(
                  onPressed: () => Navigator.pop(context), child: Text('Close'))
            ],
          );
        });
  }
}

class ParsedData {
  final String title;
  final String published;
  final String link;
  final String summary;
  bool isExpanded;

  ParsedData(
      {this.title, this.published, this.link, this.isExpanded, this.summary});
}

// onTap: () => summaryDialog(
//                         context,
//                         snapshot.data[index].summary,
//                         snapshot.data[index].link),

// RefreshIndicator(
//               onRefresh: () {
//                 return Navigator.pushReplacement(
//                     context,
//                     PageRouteBuilder(
//                         pageBuilder: (a, b, c) => RSScommon(),
//                         transitionDuration: Duration(seconds: 0)));
//               },
//               child:
