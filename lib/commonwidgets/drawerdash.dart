import 'package:ReadHeadlines/commonwidgets/categorylist.dart';
import 'package:flutter/material.dart';

class DrawerDash extends StatefulWidget {
  final String titletext;
  DrawerDash({this.titletext});
  @override
  _DrawerDashState createState() => _DrawerDashState(titletext);
}

class _DrawerDashState extends State<DrawerDash> {
  final String titletext;
  _DrawerDashState(this.titletext);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/Pg4/gradientdrawer.png'),
              fit: BoxFit.cover),
        ),
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Image.asset('assets/Pg4/categoriesicon.png'),
            ),
            CategoryList(titletext),
            Card(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/Pg4/categoryback.png'),
                      fit: BoxFit.cover),
                ),
                child: ListTile(
                    title: Text(
                  'Settings',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
