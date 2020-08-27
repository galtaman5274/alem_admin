import 'package:alem_admin/models/categories.dart';
import 'package:alem_admin/models/products.dart';
import 'package:alem_admin/screens/add/add_product.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final category=Provider.of<Product>(context,listen: false);
    //final categories=Provider.of<Categories>(context).getById(category.supcategory);
    final gender=Provider.of<Products>(context).gender;
    final brands=Provider.of<Products>(context).brands;
    final colors=Provider.of<Products>(context).color;
    final status=Provider.of<Products>(context).status;
    final size=Provider.of<Products>(context).size;
    final subcategory=Provider.of<Categories>(context).subCategory;
    final product =Provider.of<Products>(context).prodById(category.id);
    return Column(
      children: [
        ListTile(
          onTap: (){
            Navigator.push(context,
              MaterialPageRoute(builder: (context) =>
                  AddProduct(
                    action: 'editProduct',
                    gender: gender,
                    brands: brands,
                    colors: colors,
                    status: status,
                    sizes: size,
                    subcategories: subcategory,
                    editProd: product,
                  ),
              ),
            );
          },
          leading: Text(category.id),
          tileColor: Colors.teal,
          title:   Text(category.name),
          trailing: Text(category.descrip),
        ),
        SizedBox(
          height: 10,
        )
      ],

    );
  }
}
