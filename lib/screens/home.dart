import 'package:alem_admin/models/categories.dart';
import 'package:alem_admin/screens/add/add_screen.dart';
import 'package:alem_admin/screens/components/app_drawer.dart';
import 'package:alem_admin/screens/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categories=Provider.of<Categories>(context).categories;
    return SafeArea(child: Scaffold(
        appBar: AppBar(
          title: Text('Alem'),
         ),
        drawer: AppDrawer(),
        body: MainScreen(),
        floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context,
              MaterialPageRoute(builder: (context) =>
                  UploadImage(editid:(int.parse(categories[categories.length-1].id)+1).toString(),upType: 'category',action: 'addSupCategory',)));
    },
      child: Icon(Icons.add),
    ),)

    );
  }
}
