import 'package:alem_admin/models/products.dart';

import 'package:alem_admin/screens/newest/conponents/product_item.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ProductsListView extends StatefulWidget {

  @override
  _CategoryListViewState createState() => _CategoryListViewState();
}

class _CategoryListViewState extends State<ProductsListView> {
  var _isInit=true;
  var _isLoading=false;
  @override
  void initState(){
    super.initState();
  }
  @override
  void didChangeDependencies(){
    if(_isInit){
      setState(() {
        _isLoading=true;
      });
      Provider.of<Products>(context).getProducts().then((value) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit=false;
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    final products=Provider.of<Products>(context).products;
    return   _isLoading
        ? Center(child: CircularProgressIndicator(),)
        : ListView.builder(
      itemCount: products.length,
      itemBuilder: (ctx,i)=>ChangeNotifierProvider.value(value: products[i],
        child: ProductItem(),),
    );
  }
}
