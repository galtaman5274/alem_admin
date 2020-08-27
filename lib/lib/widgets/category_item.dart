import 'package:alem_admin/lib/models/category_obj.dart';
import 'package:alem_admin/lib/screens/category_screen.dart';
import 'package:alem_admin/lib/screens/home_screen.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final category=Provider.of<CategoryObject>(context,listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>
                  HomeScreen(
                    selectedIndex: 0,
                    subcategory: category.routeName,
                    subCatName: category.name,colorIndex:int.parse(category.id))),
            );
          },
          child: Image.network('https://www.alemshop.com.tm/images/category/${category.id}.jpg'),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black45,
          title: Text(category.name,textAlign: TextAlign.center,),
        ),
      ),

    );
  }
}
