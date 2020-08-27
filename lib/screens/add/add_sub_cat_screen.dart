import 'package:alem_admin/models/categories.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddSubCategory extends StatefulWidget {
  final String defaultName;
  final List<SubCategoryObject> categories;
  final String catEdid;
  final String catName;
  final String editid;
  final String upType;
  final String title ;
  final String action;
  AddSubCategory({this.catEdid ,this.defaultName,this.title,this.catName,this.editid,this.upType,this.action,this.categories}) : super();



  @override
  AddSubCategoryState createState() => AddSubCategoryState();
}

class AddSubCategoryState extends State<AddSubCategory> {
  String category='';
  String catN='';
  TextEditingController _tc;
  @override
  initState(){
    super.initState();
    if(widget.action=='addCategory' && widget.catName=='category'){
      category=widget.categories[0].runame;
    }else if(widget.action=='editCategory' && widget.catName=='category'){
      category=widget.categories[int.parse(widget.catEdid)-1].runame;
      catN=widget.defaultName;
    }
_tc=TextEditingController(text: catN);

  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Boslyk'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Bos goymak bolonok'),

              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  void fetchCat(http.Client client) async {
    switch(widget.action){
      case 'addCategory':
        await client.get('https://www.alemshop.com.tm/alem/addCat.php?'
            'table=subcategory&runame=$catN&id=${widget.editid}&category=${widget.categories.firstWhere((element) => element.runame==category).id}');
        //print(widget.categories.firstWhere((element) => element.runame==category).id);
        break;
      case 'editCategory':
        await client.get('https://www.alemshop.com.tm/alem/update.php?table=category&runame=$catN&id=${widget.editid}');
        print(widget.editid);
        break;
    }


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kategoriya Surady"),
      ),
      body: Container(
        padding: EdgeInsets.all(30.0),
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,

          children: <Widget>[
            TextField(

              controller: _tc,
              onChanged: (txt){
                setState(() {
                  catN=txt;
                });
              },
            ),


            DropdownButton(

                value: category,
                items: widget.categories
                    .map<DropdownMenuItem<String>>((SubCategoryObject value) {
                  return DropdownMenuItem<String>(
                    value: value.runame,
                    child: Text(value.runame),
                  );
                }).toList(),
                onChanged: ( value){
                  setState(() {
                    category=value;
                    print(value);
                  });
                }),
            RaisedButton(
              onPressed: (){
                if(catN==''){
                  _showMyDialog();
                }else {
                  fetchCat(http.Client());
                  Navigator.pop(context);
                }
              },
              child: Text('Yukle',style: TextStyle(
                  color: Colors.white
              ),),
            ),
          ],
        ),
      ),
    );
  }
}