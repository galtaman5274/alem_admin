import 'package:alem_admin/models/categories.dart';
import 'package:alem_admin/models/products.dart';
import 'package:alem_admin/screens/category/category_screen.dart';
import 'package:alem_admin/screens/category/subcategory_screen.dart';
import 'package:alem_admin/screens/home.dart';
import 'package:alem_admin/screens/newest/newest_screen.dart';
import 'package:alem_admin/screens/products/products_screen.dart';
import 'package:alem_admin/screens/products/types/size_screen.dart';
import 'package:alem_admin/screens/products/types/types_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(Alem());
}

class Alem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Categories()),
        ChangeNotifierProvider.value(value: Products()),
       ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Alem Admin',
        initialRoute: '/' ,
        routes: {
          '/':(ctx)=>Home(),
          'category':(ctx)=>Category(),
          'subcategory':(ctx)=>SubCategory(),
          'products':(ctx)=>ProductScreen(),
          'gender':(ctx)=>TypeScreen('gender'),
          'brands':(ctx)=>TypeScreen('brands'),
          'colors':(ctx)=>TypeScreen('colors'),
          'status':(ctx)=>TypeScreen('status'),
          'sizes':(ctx)=>SizeScreen(),
          'newest':(ctx)=>NewestScreen(),
        },
      ),
    );
  }
}
