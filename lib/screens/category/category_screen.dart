import 'package:alem_admin/screens/add/add_cat_screen.dart';
import 'package:alem_admin/screens/category/components/list_view.dart';
import 'package:alem_admin/screens/components/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:alem_admin/screens/add/add_screen.dart';
import 'package:provider/provider.dart';
import 'package:alem_admin/models/categories.dart';
class Category extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final categories=Provider.of<Categories>(context).categories;
    final subCategories=Provider.of<Categories>(context).subCategories;
    return Scaffold(
      appBar: AppBar(
        title: Text('Category'),
      ),
      drawer: AppDrawer(),
      body: CategoryListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context,
              MaterialPageRoute(builder: (context) =>
  AddCategory(
    catName: 'category',
    editid:(int.parse(subCategories[subCategories.length-1].id)+1).toString(),
    upType: 'category',
    action: 'addCategory',
    categories: categories,
  ),
              ),
          );

        },
        child: Icon(Icons.add),
      ),
    );
  }
}
