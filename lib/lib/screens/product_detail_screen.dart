import 'package:alem_admin/lib/widgets/badge.dart';
import 'package:alem_admin/lib/models/cart.dart';
import 'package:alem_admin/lib/models/categories.dart';
import 'package:alem_admin/lib/screens/cart_screen.dart';
import 'package:alem_admin/lib/widgets/checkbox_list.dart';
import 'package:alem_admin/lib/widgets/product_detail_single_scroll.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product-detail';
  final List<CheckBoxList> _colorTypes=[];
  final List<CheckBoxList> _sizeTypes=[];
  final Set<String> colorList={};
  final Set<String> sizeList={};

  @override
  Widget build(BuildContext context) {
    final productId=ModalRoute.of(context).settings.arguments as List;
    final loadedProduct=Provider.of<Categories>(context).findById(productId[0]);
    final loadedProductList=Provider.of<Categories>(context).findByIdForImages(productId[0]);

    final url='https://www.alemshop.com.tm/images/${productId[1]}/';

    final List<Widget> _imageSliders = loadedProductList.map((item) => Container(

      child: Container(

        margin: EdgeInsets.all(2.0),
        child: ClipRRect(

            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            child: Stack(

              children: <Widget>[
                Image.network(url+item.id+'.jpg', fit: BoxFit.contain, width: 1000.0,height: 1000.0,),
                Positioned(
                  bottom: 0.0,
                  left: 0.0,
                  right: 0.0,
                  child: Container(
                    decoration: BoxDecoration(
                                          ),
                    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    child: Text(
                      ' ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
               ],
            )
        ),
      ),
    )).toList();

    loadedProductList.forEach((element) {
      String curColor=element.color;
      String curSize=element.size;
      colorList.add(curColor);
      sizeList.add(curSize);


    });
    colorList.forEach((element) {
      _colorTypes.add(CheckBoxList(element));
    });
    sizeList.forEach((element) {
      _sizeTypes.add(CheckBoxList(element));
    });

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Products'),
          actions: <Widget>[
            Text('100 TMT'),
            Consumer<Cart>(
              builder: (_, cart, ch) => Badge(
                child: ch,
                value: cart.itemCount.toString(),
              ),
              child: IconButton(
                icon: Icon(
                  Icons.shopping_cart,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                },
              ),
            ),

          ],
        ),
        body: SingleScrollView(
          loadedProductList: loadedProductList ,
          imageSliders:_imageSliders,
        colorTypes: _colorTypes,
        sizeTypes: _sizeTypes,)
      ),
    );
  }
}
