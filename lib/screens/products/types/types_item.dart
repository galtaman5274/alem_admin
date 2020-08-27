import 'package:alem_admin/models/products.dart';
import 'package:alem_admin/screens/products/types/add_new_type.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TypesItem extends StatelessWidget {
  final String type;
  TypesItem(this.type);
  @override
  Widget build(BuildContext context) {
    final category=Provider.of<ProductTypes>(context,listen: false);
    //final categories=Provider.of<Categories>(context).getById(category.supcategory);

    return Column(
      children: [
        ListTile(
          onTap: (){
            Navigator.push(context,
              MaterialPageRoute(builder: (context) =>
                  AddNewType(type: type,action: 'editType',name: category.name,)
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
