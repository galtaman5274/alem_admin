import 'package:alem_admin/models/categories.dart';
import 'package:alem_admin/screens/add/add_sub_cat_screen.dart';
import 'package:alem_admin/screens/category/subcategory_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SubCategoryItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final subcategory=Provider.of<SubCategoryObj>(context,listen: false);
    final categories=Provider.of<Categories>(context).getByIdSub(subcategory.category);
    final categoryy=Provider.of<Categories>(context).subCategories;
    return Column(
      children: [
        ListTile(
          onTap: (){
            Navigator.push(context,
                MaterialPageRoute(builder: (context) =>
                    AddSubCategory(
                      catEdid: subcategory.category,
                      defaultName: subcategory.runame,
                      catName: 'category',
                      editid:subcategory.id,
                      upType: 'category',
                      action: 'editCategory',
                      categories: categoryy,
                    )));
          },
          leading: Text(subcategory.id),
          tileColor: Colors.teal,
          title:   Text(subcategory.runame),
          trailing: Text(categories.runame),
        ),
        SizedBox(
          height: 10,
        )
      ],

    );
  }
}
