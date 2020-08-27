import 'package:alem_admin/models/products.dart';

import 'package:alem_admin/screens/products/conponents/product_item.dart';
import 'package:alem_admin/screens/products/types/types_item.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class TypesListView extends StatefulWidget {
  final String type;
  TypesListView(this.type);

  @override
  _TypesListView createState() => _TypesListView();
}

class _TypesListView extends State<TypesListView> {
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
      switch(widget.type){
        case 'gender':
          Provider.of<Products>(context).getGender().then((value) {
            setState(() {
              _isLoading = false;
            });
          });
          break;
        case 'brands':
          Provider.of<Products>(context).getBrands().then((value) {
            setState(() {
              _isLoading = false;
            });
          });
          break;
        case 'colors':
          Provider.of<Products>(context).getColors().then((value) {
            setState(() {
              _isLoading = false;
            });
          });
          break;
        case 'status':
          Provider.of<Products>(context).getStatus().then((value) {
            setState(() {
              _isLoading = false;
            });
          });
          break;
        case 'size':
          Provider.of<Products>(context).getSize().then((value) {
            setState(() {
              _isLoading = false;
            });
          });
          break;
      }

    }
    _isInit=false;
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {

    final products=Provider.of<Products>(context).types(widget.type);
    return   _isLoading
        ? Center(child: CircularProgressIndicator(),)
        : ListView.builder(
      itemCount: products.length,
      itemBuilder: (ctx,i)=>ChangeNotifierProvider.value(value: products[i],
        child: TypesItem(widget.type),),
    );
  }
}
