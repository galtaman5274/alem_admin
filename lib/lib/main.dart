import 'package:alem_admin/lib/models/cart.dart';
import 'package:alem_admin/lib/models/orders.dart';
import 'package:alem_admin/lib/screens/orders_screen.dart';
import 'package:alem_admin/lib/screens/cart_screen.dart';
import 'package:alem_admin/lib/screens/product_detail_screen.dart';
import 'package:alem_admin/lib/models/categories.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';

void main()=>runApp(AlemApp());

class AlemApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Categories()),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        ChangeNotifierProvider.value(
          value: Orders(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Alem Shop',
        theme: ThemeData(
          primarySwatch: Colors.orange,
          accentColor: Colors.amberAccent,
          fontFamily: 'Lato'
        ),
        home: HomeScreen(selectedIndex: 0,subcategory: 'main',colorIndex: 0,),
        routes: {
          ProductDetailScreen.routeName:(ctx)=>ProductDetailScreen(),
          CartScreen.routeName: (ctx) => CartScreen(),
          OrdersScreen.routeName: (ctx) => OrdersScreen(),
        },

      ),
    );
  }
}
