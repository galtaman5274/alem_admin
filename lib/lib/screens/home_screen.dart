import 'package:alem_admin/lib/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'category_screen.dart';

class HomeScreen extends StatefulWidget {
  final int selectedIndex;
  final String subcategory;
  final String subCatName;
  final int colorIndex;
  HomeScreen({Key key,this.selectedIndex,this.subcategory,this.subCatName,this.colorIndex}):super(key:key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex;
List<Map<String,Object>> _pages;
List<Color> _forSubCategory=[Colors.orange,
  Colors.cyan,Colors.green,
  Colors.deepPurple,
  Colors.purple,
  Colors.pink,Colors.teal,
  Colors.indigo,Colors.red,
  Colors.yellow,Colors.amber];

@override
void initState() {
  _selectedIndex=widget.selectedIndex;
  _pages = [
    {
      'title': widget.subcategory=='main'? 'Alem Shop':widget.subCatName,
      'page':CategoryScreen(widget.subcategory)
    },
    {
      'title': 'Поиск'
    },
    {
      'title': 'Избранныe'
    },
    {
      'title': 'Профиль'
    }
  ];
  super.initState();
}
  void setIndex(int index){
    setState(() {
      _selectedIndex=index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(_pages[_selectedIndex]['title']),
          backgroundColor: _forSubCategory[widget.colorIndex],
        ),
        bottomNavigationBar: BottomNavigationBar(

          backgroundColor: Colors.black45,
          selectedItemColor: Colors.black45,
          onTap: setIndex,
          currentIndex: _selectedIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Alem'),
              backgroundColor: Colors.orange
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.search),
                title: Text('Поиск'),
                backgroundColor: Colors.orange
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.star),
                title: Text('Избранныe'),
                backgroundColor: Colors.orange
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle),
                title: Text('Профиль'),
                backgroundColor: Colors.orange
            ),
          ],
        ),
        body: _pages[_selectedIndex]['page'],
        drawer: AppDrawer(),
      ),
    );
  }
}
