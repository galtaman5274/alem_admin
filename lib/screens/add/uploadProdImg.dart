import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class UploadProdImage extends StatefulWidget {

  final String editid;
  final String type;

  UploadProdImage({this.type,this.editid=''}) : super();



  @override
  UploadProdImageState createState() => UploadProdImageState();
}

class UploadProdImageState extends State<UploadProdImage> {
  //
  static final String uploadEndPoint =
      'https://www.alemshop.com.tm/alem/uploadProdImg.php';
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


  upload() {
    http.post(uploadEndPoint, body: {
      "image": base64Image,
      "type":widget.type,
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