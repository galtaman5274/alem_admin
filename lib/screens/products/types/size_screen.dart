import 'package:alem_admin/models/categories.dart';
import 'package:alem_admin/models/products.dart';
import 'package:alem_admin/screens/components/app_drawer.dart';
import 'package:alem_admin/screens/products/types/add_new_size.dart';
import 'package:alem_admin/screens/products/types/size_list_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SizeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final categories=Provider.of<Categories>(context).subCategories;
    return Scaffold(
      appBar: AppBar(
        title: Text('Category'),
      ),
      drawer: AppDrawer(),
      body: SizeListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context,
            MaterialPageRoute(builder: (context) =>
                AddNewSize( type:  'size',action: 'addSize',categories: categories,)
            ),
          );

        },
        child: Icon(Icons.add),
      ),
    );
  }
}
