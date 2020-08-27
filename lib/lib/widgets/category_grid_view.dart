import 'package:alem_admin/lib/models/categories.dart';
import 'package:alem_admin/lib/widgets/category_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryGridView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
   final  categories=Provider.of<Categories>(context).categories;
       return GridView.builder(
      padding: EdgeInsets.all(10.0),
      itemCount: categories.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,

        crossAxisSpacing: 10,
        mainAxisSpacing: 10,),
      itemBuilder: (ctx,i)=>ChangeNotifierProvider.value(value: categories[i],
      child: CategoryItem(),),
    );
  }
}
