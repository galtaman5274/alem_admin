import 'package:alem_admin/lib/models/categories.dart';
import 'package:alem_admin/lib/models/subcategory.dart';
import 'package:alem_admin/lib/widgets/subcategory_grid_view.dart';
import 'package:alem_admin/lib/widgets/category_grid_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatefulWidget {
  final String subcategory;
  CategoryScreen(this.subcategory);
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
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
      if(widget.subcategory=='main') {
        Provider.of<Categories>(context).getCategories().then((value) {
          setState(() {
            _isLoading = false;
          });
        });
      }else{
        Provider.of<Categories>(context).getSubCategories(widget.subcategory).then((value) {
          setState(() {
            _isLoading = false;
          });
        });
      }
    }
    _isInit=false;
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return _isLoading
      ? Center(child: CircularProgressIndicator(),)
      : widget.subcategory=='main'? CategoryGridView():SubcategoryScreen(widget.subcategory);
  }
}
