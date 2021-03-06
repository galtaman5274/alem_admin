import 'package:alem_admin/models/categories.dart';
import 'package:alem_admin/screens/category/components/list_item.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class CategoryListView extends StatefulWidget {
 
  @override
  _CategoryListViewState createState() => _CategoryListViewState();
}

class _CategoryListViewState extends State<CategoryListView> {
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
      Provider.of<Categories>(context).getSubCategories().then((value) {
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
    final categories=Provider.of<Categories>(context).subCategories;
    return   _isLoading
        ? Center(child: CircularProgressIndicator(),)
        : ListView.builder(
      itemCount: categories.length,
        itemBuilder: (ctx,i)=>ChangeNotifierProvider.value(value: categories[i],
          child: CategoryItem(),),
    );
  }
}
