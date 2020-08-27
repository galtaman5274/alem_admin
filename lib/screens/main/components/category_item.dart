import 'package:alem_admin/models/categories.dart';
import 'package:alem_admin/screens/add/add_screen.dart';
import 'package:alem_admin/screens/category/category_screen.dart';
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
            onTap:(){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) =>
                      UploadImage(

                        editid:category.id,
                        title: category.runame,
                        catName: category.name,
                        upType: 'category',action: 'editSupCat',)));
            },

            child: Image.network('https://www.alemshop.com.tm/images/category/${category.id}.jpg'),
            
          ),
          footer: GridTileBar(
            backgroundColor: Colors.black54,
            title: Text(category.runame,textAlign: TextAlign.center,),
          ),
    )
    );
  }
}
