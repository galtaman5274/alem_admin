import 'package:alem_admin/screens/components/app_drawer.dart';
import 'package:alem_admin/screens/newest/conponents/products_list_view.dart';
import 'package:flutter/material.dart';


class NewestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: Text('Category'),
      ),
      drawer: AppDrawer(),
      body: ProductsListView(),

    );
  }
}
