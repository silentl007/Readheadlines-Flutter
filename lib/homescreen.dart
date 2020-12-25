import 'package:flutter/material.dart';
import 'package:ReadHeadlines/newsscreens/worldnews.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(
              child: InkWell(
                onTap: () {
                  print('local news');
                },
                child: Opacity(
                  opacity: .92,
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/Pg2/localnews.png'),
                            fit: BoxFit.cover)),
                    child: Center(
                      child: Text('Local News',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                          )),
                    ),
                  ),
                ),
              ),
              flex: 1,
            ),
            Expanded(
              child: GestureDetector(
                onTap: () => world(context),
                child: Opacity(
                  opacity: .91,
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/Pg2/worldnews.png'),
                            fit: BoxFit.cover)),
                    child: Center(
                      child: Text('World News',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                          )),
                    ),
                  ),
                ),
              ),
              flex: 1,
            )
          ],
        ),
      ),
    );
  }

  void world(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => WorldNews()));
  }
}
