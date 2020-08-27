import 'package:alem_admin/models/categories.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class UploadImage extends StatefulWidget {
  final String defaultName;
  final String catName;
  final String editid;
  final String upType;
  final String title ;
  final String action;
  UploadImage({this.defaultName, this.title,this.catName,this.editid,this.upType,this.action}) : super();



  @override
  UploadImageDemoState createState() => UploadImageDemoState();
}

class UploadImageDemoState extends State<UploadImage> {
  //
  static final String uploadEndPoint =
      'https://www.alemshop.com.tm/alem/upload.php';
  Future<File> file;
  String status = '';
  String base64Image;
  File tmpFile;
  String errMessage = 'Servere yuklelen wagty nasazlyk yuze cykdy';
TextEditingController _tc;
  chooseImage() {
    setState(() {
      file = ImagePicker.pickImage(source: ImageSource.gallery);
    });
    setStatus('');
  }

  setStatus(String message) {
    setState(() {
      status = message;
    });
  }

  startUpload() {
    setStatus('Surat Yuklenyar...');
    if (null == tmpFile) {
      setStatus(errMessage);
      return;
    }

    upload();

  }
  String catN='' ;
  @override
  initState(){
    super.initState();
         catN=widget.defaultName;
    if(catN==null){
      catN = widget.title;
    }
_tc=TextEditingController(text: catN);
  }
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('AlertDialog Title'),
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
        case 'addSupCategory':
          await client.get('https://www.alemshop.com.tm/alem/addCat.php?table=supcategory&runame=$catN&id=${widget.editid}');

          break;
        case 'editSupCat':
          await client.get('https://www.alemshop.com.tm/alem/update.php?table=supcategory&runame=$catN&id=${widget.editid}');
          break;
      }



catN='';
  }
  upload() {
    http.post(uploadEndPoint, body: {
      "image": base64Image,
      "type":widget.upType,
      "id":widget.editid
    }).then((result) {
      setStatus(result.statusCode == 200 ? result.body : errMessage);
    }).catchError((error) {
      setStatus(error);
    });
  }

  Widget showImage() {
    return FutureBuilder<File>(
      future: file,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            null != snapshot.data) {
          tmpFile = snapshot.data;
          base64Image = base64Encode(snapshot.data.readAsBytesSync());
          return Flexible(
            child: Image.file(
              snapshot.data,
              fit: BoxFit.fill,
            ),
          );
        } else if (null != snapshot.error) {
          return const Text(
            'Surady saylap bilmedi',
            textAlign: TextAlign.center,
          );
        } else {
          return const Text(
            'Surady Saylan',
            textAlign: TextAlign.center,
          );
        }
      },
    );
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
            RaisedButton(
                onPressed: (){
                  if(catN==''){
                    _showMyDialog();
                  }
                  fetchCat(http.Client());
                },
              child: Text('Yukle',style: TextStyle(
                color: Colors.white
              ),),
            ),
            OutlineButton(
              onPressed: chooseImage,
              child: Text('Surady sayla'),
            ),
            SizedBox(
              height: 20.0,
            ),
            showImage(),
            SizedBox(
              height: 20.0,
            ),
            OutlineButton(
              onPressed: (){startUpload();},
              child: Text('Surady yukle'),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              status,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.w500,
                fontSize: 20.0,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }
}