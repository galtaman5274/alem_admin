import 'package:alem_admin/models/products.dart';

import 'package:alem_admin/screens/products/conponents/product_item.dart';
import 'package:alem_admin/screens/products/types/size_item.dart';
import 'package:alem_admin/screens/products/types/types_item.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class SizeListView extends StatefulWidget {


  @override
  _SizeListView createState() => _SizeListView();
}

class _SizeListView extends State<SizeListView> {
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
          Provider.of<Products>(context).getSize().then((value) {
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

    final products=Provider.of<Products>(context).size;
    return   _isLoading
        ? Center(child: CircularProgressIndicator(),)
        : ListView.builder(
      itemCount: products.length,
      itemBuilder: (ctx,i)=>ChangeNotifierProvider.value(value: products[i],
        child: SizeItem(),),
    );
  }
}
