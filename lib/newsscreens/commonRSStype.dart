import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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
              title: info['title'],
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
      print('-------------------error------------------');
      print(e);
      print('-------------------error------------------');
      return feeddata;
    }
  }

  void _reset() {
    // reset function for no internet
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: _feedprocess(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData == false) {
            return Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/Pg2/worldnews.png'),
                      fit: BoxFit.cover)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(
                    valueColor:
                        new AlwaysStoppedAnimation<Color>(Colors.blue[200]),
                    backgroundColor: Colors.grey[300],
                    strokeWidth: 2.0,
                  ), // loading animation for fetching data
                  Text(
                    'Fetching Data',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )
                ],
              ),
            );
          } else if (snapshot.data[0] == 'failed') {
            return Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/Pg2/worldnews.png'),
                      fit: BoxFit.cover)),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'No Internet Connection',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ), // reset button if no internet
                    RaisedButton(child: Text('Retry'), onPressed: _reset),
                  ]),
            );
          }
          return Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/Pg2/worldnews.png'),
                    fit: BoxFit.cover)),
            child: ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                    color: Colors.transparent,
                    child: ListTile(
                      tileColor: Colors.transparent,
                      leading: Icon(
                        Icons.double_arrow,
                        color: Colors.white,
                      ),
                      // trailing: IconButton(icon: Icon(Icons.share, color: Colors.white,),),
                      title: Text(
                        snapshot.data[index].title.toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () =>
                          webviewcaller(context, snapshot.data[index].link),
                      onLongPress: () {
                        print('object');
                      },
                    ));
              },
            ),
          );
        },
      ),
    );
  }
}

class ParsedData {
  final String title;
  final String published;
  final String link;
  final String summary;
  bool isExpanded;

  ParsedData(
      {this.title, this.published, this.link, this.summary, this.isExpanded});
}

void webviewcaller(BuildContext context, String url) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => WebViewPage(url)));
}

summaryDialog(BuildContext context, String summary, String link) {
  /* ---- summary function -------*/
  /* () => summaryDialog(context,
                    snapshot.data[index].summary, snapshot.data[index].link) */
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
