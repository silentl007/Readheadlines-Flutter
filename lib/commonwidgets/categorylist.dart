import 'package:ReadHeadlines/newsscreens/sports.dart';
import 'package:ReadHeadlines/newsscreens/worldnews.dart';
import 'package:flutter/material.dart';

class CategoryList extends StatelessWidget {
  final String titletext;
  CategoryList(this.titletext);
  final List categories = ['Headlines', 'Sports', 'Business', 'Politics', 'Travel'];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: categories
          .map<Widget>((categoryname) => Card(
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/Pg4/categoryback.png'),
                        fit: BoxFit.cover),
                  ),
                  child: ListTile(
                    title: Text(
                      categoryname,
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                    onTap: () =>
                        categoryroute(category: categoryname, context: context),
                  ),
                ),
              ))
          .toList(),
    );
  }

  void categoryroute({BuildContext context, String category}) {
    if (category == titletext) {
      Navigator.pop(context);
    } else if (category == 'Business') {
      print(category);
    } else if (category == 'Travel') {
      print(category);
    } else if (category == 'Politics') {
      print(category);
    } else if (category == 'Headlines') {
      Navigator.pop(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => WorldNews()));
    } else if (category == 'Sports') {
      Navigator.pop(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Soccer()));
    }
  }
}
