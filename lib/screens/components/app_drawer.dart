import 'package:alem_admin/screens/home.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(

              color: Colors.blue
            ),
            child: Container(
              child: Center(
                child: Text('Alem'),
              ),
            ),
          ),
          ListTile(
            title: Text('esasy category'),
          leading: Icon(Icons.account_balance),
            onTap: ()=> Navigator.pushNamed(context,'/' )
          ),
          ListTile(
              title: Text('category'),
              leading: Icon(Icons.account_balance),
              onTap: ()=> Navigator.pushNamed(context, 'category'),
          ),
          ListTile(
            title: Text('category'),
            leading: Icon(Icons.account_balance),
            onTap: ()=> Navigator.pushNamed(context, 'subcategory'),
          ),
          ListTile(
            title: Text('products'),
            leading: Icon(Icons.account_balance),
            onTap: ()=> Navigator.pushNamed(context, 'products'),
          ),
          ListTile(
            title: Text('gender'),
            leading: Icon(Icons.account_balance),
            onTap: ()=> Navigator.pushNamed(context, 'gender'),
          ),
          ListTile(
            title: Text('brands'),
            leading: Icon(Icons.account_balance),
            onTap: ()=> Navigator.pushNamed(context, 'brands'),
          ),
          ListTile(
            title: Text('colors'),
            leading: Icon(Icons.account_balance),
            onTap: ()=> Navigator.pushNamed(context, 'colors'),
          ),
          ListTile(
            title: Text('status'),
            leading: Icon(Icons.account_balance),
            onTap: ()=> Navigator.pushNamed(context, 'status'),
          ),
          ListTile(
            title: Text('sizes'),
            leading: Icon(Icons.account_balance),
            onTap: ()=> Navigator.pushNamed(context, 'sizes'),
          ),
          ListTile(
            title: Text('newest'),
            leading: Icon(Icons.account_balance),
            onTap: ()=> Navigator.pushNamed(context, 'newest'),
          ),
        ],
      ),
    );
  }
}
