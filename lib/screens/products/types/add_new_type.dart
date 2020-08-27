import 'package:alem_admin/models/products.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
class AddNewType extends StatefulWidget {
  final String type;
  final String action;
  final String name;
  AddNewType({this.type,this.action,this.name});

  @override
  _AddNewTypeState createState() => _AddNewTypeState();
}

class _AddNewTypeState extends State<AddNewType> {
  String defaultName='';
  TextEditingController _tc;
  String id;
  @override
  void initState() {
   super.initState();
   defaultName=widget.name;
   if(widget.action=='editType'){

     switch(widget.type){
       case 'gender':
         id=Provider.of<Products>(context, listen: false).genderByName(defaultName).id;
         break;
       case 'brands':

         id=Provider.of<Products>(context, listen: false).brandByName(defaultName).id;
         print(defaultName);
         break;
       case 'colors':
         id=Provider.of<Products>(context, listen: false).colorByName(defaultName).id;
         break;
       case 'status':
         id=Provider.of<Products>(context, listen: false).statusByName(defaultName).id;
         break;
     }
   }

  _tc = TextEditingController(text: defaultName);
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
      case 'addType':
        await client.get('https://www.alemshop.com.tm/alem/addProd.php?'
            'action=${widget.type}&name=$defaultName');

        break;
      case 'editType':

        await client.get('https://www.alemshop.com.tm/alem/updateProd.php?'
            'action=${widget.type}&name=$defaultName&id=$id');
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
