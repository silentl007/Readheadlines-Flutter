import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:share/share.dart';

class WebViewPage extends StatefulWidget {
  final urllink;
  WebViewPage(this.urllink);
  @override
  _WebViewPageState createState() => _WebViewPageState(this.urllink);
}

class _WebViewPageState extends State<WebViewPage> {
  var _url;
  final key = UniqueKey();
  _WebViewPageState(this._url);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // if (Platform.isAndroid) WebView.platform
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   child: IconButton(
      //     icon: Icon(Icons.bookmark_border),
      //     onPressed: null,
      //   ),
      //   onPressed: null,
      // ),
      appBar: AppBar(
        actions: <Widget>[
          IconButton(icon: Icon(Icons.share), onPressed: share)
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: WebView(
              gestureRecognizers: [Factory<VerticalDragGestureRecognizer>(() => VerticalDragGestureRecognizer())].toSet(),
              javascriptMode: JavascriptMode.unrestricted,
              key: key,
              initialUrl: _url,
            ),
          )
        ],
      ),
    );
  }

  void share() {
    String shareurl = _url.toString();
    Share.share(shareurl);
  }
}
