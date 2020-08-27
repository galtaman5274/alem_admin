import 'package:alem_admin/models/categories.dart';
import 'package:alem_admin/screens/add/add_cat_screen.dart';
import 'package:alem_admin/screens/add/add_sub_cat_screen.dart';
import 'package:alem_admin/screens/category/components/sub_cat_view.dart';
import 'package:alem_admin/screens/components/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SubCategory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categories=Provider.of<Categories>(context).subCategories;
    final subCategories=Provider.of<Categories>(context).subCategory;
    return Scaffold(

      appBar: AppBar(
        title: Text('Category'),
      ),
      drawer: AppDrawer(),
      body: SubCategoryListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context,
              MaterialPageRoute(builder: (context) =>
                  AddSubCategory(
                    catName: 'category',
                    editid:(int.parse(categories[subCategories.length-1].id)+1).toString(),
                    upType: 'category',
                    action: 'addCategory',
                    categories: categories,
                  )));

        },
        child: Icon(Icons.add),
      ),
    );
  }
}
