import 'package:alem_admin/models/categories.dart';
import 'package:alem_admin/models/products.dart';
import 'package:alem_admin/screens/main/components/category_item.dart';
import 'package:alem_admin/screens/main/components/main_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
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
      Provider.of<Categories>(context).getCategories().then((value) {
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
       return  _isLoading
            ? Center(child: CircularProgressIndicator(),)
            : MainGridView();
  }
}
