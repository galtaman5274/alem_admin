import 'package:alem_admin/models/categories.dart';
import 'package:alem_admin/models/products.dart';
import 'package:alem_admin/screens/category/subcategory_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
class AddNewSize extends StatefulWidget {
  final String type;
  final String action;

  final Size curSizeObj;
  final List<SubCategoryObject> categories;
  AddNewSize({this.type,this.action,this.categories,this.curSizeObj});

  @override
  _AddNewSizeState createState() => _AddNewSizeState();
}

class _AddNewSizeState extends State<AddNewSize> {
  String defaultName='';
  TextEditingController _tc;
  String id;
  String category;
  String curId;
  String catId;
  @override
  void initState() {
    super.initState();


   if(widget.action=='addSize') {

      category = widget.categories[0].runame;
      _tc=TextEditingController(text: defaultName);
    }else{
     id=widget.curSizeObj.id;
      defaultName = widget.curSizeObj.name;
      category = widget.categories[int.parse(widget.curSizeObj.category)-1].runame;
     _tc=TextEditingController(text: defaultName);
   }

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




    catId=Provider.of<Categories>(context, listen: false).getSubCatByName(category).id;


    switch(widget.action){
      case 'addSize':

        await client.get('https://www.alemshop.com.tm/alem/addProd.php?'
            'action=${widget.type}&name=$defaultName&category=$catId');

        break;
      case 'editSize':

        await client.get('https://www.alemshop.com.tm/alem/updateProd.php?'
            'action=${widget.type}&name=$defaultName&id=$id&category=$catId');
        break;
    }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Type'),
      ),
      body: Container(
        padding: EdgeInsets.all(30.0),
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,

          children: <Widget>[
            Text('Name'),
            TextField(

              autofocus: false,
              controller: _tc,
              onChanged: (txt){
                setState(() {
                  defaultName=txt;
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
                onChanged: (String value){
                  setState(() {
                    category=value;
                    print(value);
                  });
                }),
            RaisedButton(
              onPressed: (){
                if(defaultName==''){
                  _showMyDialog();
                }else{
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
