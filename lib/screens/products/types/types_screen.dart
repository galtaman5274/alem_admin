import 'package:alem_admin/screens/category/components/sub_cat_view.dart';
import 'package:alem_admin/screens/components/app_drawer.dart';
import 'package:alem_admin/screens/products/types/add_new_type.dart';
import 'package:alem_admin/screens/products/types/types_list_view.dart';
import 'package:flutter/material.dart';

class TypeScreen extends StatelessWidget {
  final String type;
  TypeScreen(this.type);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Category'),
      ),
      drawer: AppDrawer(),
      body: TypesListView(type),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context,
            MaterialPageRoute(builder: (context) =>
                AddNewType(type: type,action: 'addType')
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
