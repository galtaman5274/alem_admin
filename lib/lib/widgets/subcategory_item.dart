import 'package:alem_admin/lib/aa/screens/product_detail_screen.dart';
import 'package:alem_admin/lib/models/cart.dart';
import 'package:alem_admin/lib/models/category_obj.dart';
import 'package:alem_admin/lib/models/subcategory.dart';
import 'package:alem_admin/lib/screens/category_screen.dart';
import 'package:alem_admin/lib/screens/home_screen.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SubCategoryItem extends StatelessWidget {
  final String subcategory;
  SubCategoryItem(this.subcategory);
  @override
  Widget build(BuildContext context) {
    final category=Provider.of<Subcategory>(context,listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetailScreen.routeName,
              arguments: [category.alemid,subcategory]
            );
          },
          child: Image.network('https://www.alemshop.com.tm/images/$subcategory/${category.id}.jpg',
          fit: BoxFit.cover,),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black45,
          title: Text(category.name,textAlign: TextAlign.center,),
          leading: Consumer<Subcategory>(

            builder: (ctx,category,_)=>IconButton(
              constraints: BoxConstraints(
                  maxWidth: 30
              ),
            padding: EdgeInsets.zero,
              icon: Icon(
                category.isFavorite
                    ? Icons.favorite
                    :Icons.favorite_border
              ),
              color: Theme.of(context).accentColor,
              onPressed: (){
                category.toggleFavoriteStatus();
              },
            ),
          ),
          trailing: IconButton(
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(
              maxWidth: 30
            ),
            icon: Icon(Icons.shopping_cart),
            onPressed: (){
              cart.addItem(category.id,double.parse(category.price), category.name,subcategory);
              Scaffold.of(context).hideCurrentSnackBar();
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text('towar dobawlen'),
                  duration: Duration(seconds: 2),
                )
              );
            },
            color: Theme.of(context).accentColor,
          ),

        ),
      ),

    );
  }
}
