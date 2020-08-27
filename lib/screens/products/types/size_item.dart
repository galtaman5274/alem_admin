import 'package:alem_admin/models/categories.dart';
import 'package:alem_admin/models/products.dart';
import 'package:alem_admin/screens/products/types/add_new_size.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SizeItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final category=Provider.of<Size>(context,listen: false);
    final categories=Provider.of<Categories>(context).subCategories;
    //final categories=Provider.of<Categories>(context).getById(category.supcategory);

    return Column(
      children: [
        ListTile(
          onTap: (){
            Navigator.push(context,
              MaterialPageRoute(builder: (context) =>
                  AddNewSize( type:  'size',action: 'editSize',categories: categories,curSizeObj: category,)
              ),
            );
          },
          leading: Text(category.id),
          tileColor: Colors.teal,
          title:   Text(category.name),

        ),
        SizedBox(
          height: 10,
        )
      ],

    );
  }
}
