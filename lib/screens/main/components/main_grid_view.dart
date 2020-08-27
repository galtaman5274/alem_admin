import 'package:flutter/material.dart';
import 'package:alem_admin/models/categories.dart';
import 'package:alem_admin/screens/main/components/category_item.dart';
import 'package:provider/provider.dart';

class MainGridView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categories=Provider.of<Categories>(context).categories;

    return GridView.builder(
      padding: EdgeInsets.all(10.0),
      itemCount: categories.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: MediaQuery.of(context).size.width< 500? 2:3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,),
      itemBuilder: (ctx,i)=>ChangeNotifierProvider.value(value: categories[i],
        child: CategoryItem(),),
    );
  }
}
