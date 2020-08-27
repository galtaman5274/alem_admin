import 'package:alem_admin/models/categories.dart';
import 'package:alem_admin/models/products.dart';
import 'package:alem_admin/screens/add/add_product.dart';
import 'package:alem_admin/screens/category/components/sub_cat_view.dart';
import 'package:alem_admin/screens/components/app_drawer.dart';
import 'package:alem_admin/screens/products/conponents/products_list_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final gender=Provider.of<Products>(context).gender;
    final brands=Provider.of<Products>(context).brands;
    final colors=Provider.of<Products>(context).color;
    final status=Provider.of<Products>(context).status;
    final size=Provider.of<Products>(context).size;
    final subcategory=Provider.of<Categories>(context).subCategory;

    return Scaffold(
      appBar: AppBar(
        title: Text('Category'),
      ),
      drawer: AppDrawer(),
      body: ProductsListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context,
            MaterialPageRoute(builder: (context) =>
                AddProduct(
                  action: 'addProduct',
                  gender: gender,
                  brands: brands,
                  colors: colors,
                  status: status,
                  sizes: size,
                  subcategories: subcategory,

                ),
            ),
          );

        },
        child: Icon(Icons.add),
      ),
    );
  }
}
