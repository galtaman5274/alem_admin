import 'package:alem_admin/models/categories.dart';
import 'package:alem_admin/screens/add/add_cat_screen.dart';
import 'package:alem_admin/screens/category/subcategory_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final category=Provider.of<SubCategoryObject>(context,listen: false);
    final categories=Provider.of<Categories>(context).getById(category.supcategory);
    final categoryy=Provider.of<Categories>(context).categories;

    return Column(
      children: [
        ListTile(
          onTap: (){
            Navigator.push(context,
                MaterialPageRoute(builder: (context) =>
                    AddCategory(
                      catEdid: category.supcategory,
                      defaultName: category.runame,
                      catName: 'category',
                      editid:category.id,
                      upType: 'category',
                      action: 'editCategory',
                      categories: categoryy,
                    )));
          },
          leading: Text(category.id),
          tileColor: Colors.teal,
          title:   Text(category.runame),
          trailing: Text(categories.runame),
        ),
        SizedBox(
          height: 10,
        )
      ],

    );
  }
}
