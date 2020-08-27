import 'package:alem_admin/lib/widgets/subcategory_item.dart';
import 'package:flutter/material.dart';
import 'package:alem_admin/lib/models/categories.dart';
import 'package:alem_admin/lib/widgets/category_item.dart';
import 'package:provider/provider.dart';
class SubcategoryScreen extends StatelessWidget {
  final String subcategory;
  SubcategoryScreen(this.subcategory);

  @override
  Widget build(BuildContext context) {
    final  categories=Provider.of<Categories>(context).sortedSubcategories;
    return GridView.builder(
      padding: EdgeInsets.all(10.0),
      itemCount: categories.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,

        crossAxisSpacing: 10,
        mainAxisSpacing: 10,),
      itemBuilder: (ctx,i)=>ChangeNotifierProvider.value(value: categories[i],
        child: SubCategoryItem(subcategory),),
    );
  }
}

