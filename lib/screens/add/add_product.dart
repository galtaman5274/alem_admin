import 'package:alem_admin/models/categories.dart';
import 'package:alem_admin/models/products.dart';
import 'package:alem_admin/screens/add/uploadProdImg.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
class AddProduct extends StatefulWidget {
  final String prodName;
  final  List<ProductTypes> gender;
  final  List<ProductTypes> brands;
  final  List<ProductTypes> colors;
  final  List<ProductTypes> status;
  final  List<Size> sizes;
  final List<SubCategoryObj> subcategories;
  final int genderid;
  final int brandid;
  final int colorid;
  final int statusid;
  final int sizeid;
  final String action;
  final int subCatId;
  final Product editProd;

  AddProduct({this.action,this.prodName='',this.genderid=0,this.gender,this.status,this.brands,this.colors,this.sizes,
  this.brandid=0,this.colorid=0,this.sizeid=0,this.statusid=0,
    this.subcategories,this.subCatId=0,this.editProd}):super();
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  String defaultName='';
  String defaultDesc='';
String defaultGender;
String defaultBrand;
String defaultColor;
String defaultStatus;
String defaultSize;
String subcategory;
TextEditingController _tc;
TextEditingController _tcd;
  TextEditingController _tcp;
  TextEditingController _tcq;
String prodid;
String brandid;
String genderid;
String colorid;
String sizeid;
String statusid;
int lastProdid;
String price;
String qunatity;
String subCatId;
bool checkbox=false;
Product curProd;
  @override
  void initState() {
    if(widget.editProd==null) {
      defaultName = widget.prodName;
      subcategory = widget.subcategories[widget.subCatId].runame;
      defaultGender = widget.gender[widget.genderid].name;
      defaultBrand = widget.brands[widget.brandid].name;
      defaultColor = widget.colors[widget.colorid].name;
      defaultStatus = widget.status[widget.statusid].name;
      defaultSize = widget.sizes[widget.sizeid].name;
      _tc=TextEditingController(text: defaultName);
      _tcd=TextEditingController(text: defaultDesc);
      _tcp=TextEditingController(text: price);
      _tcq=TextEditingController(text: qunatity);
    }else{
      curProd=widget.editProd;
      defaultName = curProd.name;
      defaultDesc = curProd.descrip;
      subcategory = widget.subcategories[int.parse(curProd.subcategory)-1].runame;
      defaultGender = widget.gender[int.parse(curProd.gender)-1].name;
      defaultBrand = widget.brands[int.parse(curProd.brand)-1].name;
      defaultColor = widget.colors[int.parse(curProd.color)-1].name;
      defaultStatus = widget.status[int.parse(curProd.status)-1].name;
      defaultSize = widget.sizes[int.parse(curProd.size)-1].name;
      _tc=TextEditingController(text: defaultName);
      _tcd=TextEditingController(text: defaultDesc);
      _tcp=TextEditingController(text: curProd.price);
      _tcq=TextEditingController(text: curProd.quantity);
      checkbox=curProd.newest=='0'? false:true;
    }


    super.initState();
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

    lastProdid=Provider.of<Products>(context, listen: false).products.length;
    prodid=Provider.of<Products>(context, listen: false).products[lastProdid-1].id;
    brandid=Provider.of<Products>(context, listen: false).brandByName(defaultBrand).id;
    genderid=Provider.of<Products>(context, listen: false).genderByName(defaultGender).id;
    colorid=Provider.of<Products>(context, listen: false).colorByName(defaultColor).id;
    statusid=Provider.of<Products>(context, listen: false).statusByName(defaultStatus).id;
    sizeid=Provider.of<Products>(context, listen: false).sizeByName(defaultSize).id;
    subCatId=Provider.of<Categories>(context, listen: false).getCatByName(subcategory).id;

    switch(widget.action){
      case 'addProduct':
        await client.get('https://www.alemshop.com.tm/alem/addProd.php?'
            'action=products&name=$defaultName&descrip=$defaultDesc'
            '&price=$price&quantity=$qunatity&brand=$brandid&gender=$genderid&color=$colorid&status=$statusid'
            '&size=$sizeid&subcategory=$subCatId&newest=${checkbox?'1':'0'}&alemid=${int.parse(prodid)+1}s$subCatId');

        break;
      case 'editProduct':
        await client.get('https://www.alemshop.com.tm/alem/updateProd.php?'
            'action=product&name=$defaultName&descrip=$defaultDesc&price=$price'
            '&quantity=$qunatity&brand=$brandid&gender=$genderid&color=$colorid&status=$statusid'
            '&size=$sizeid&subcategory=$subCatId&newest=${checkbox?'1':'0'}&id=${curProd.id}&alemid=${curProd.alemid}');

      /*await client.get("https://www.alemshop.com.tm/alem/updateProd.php?"
          "action=product&name=$defaultName&descrip=$defaultDesc&price=$price&quantity=$qunatity&brand=$brandid&gender=1&color=2&status=2&size=2&subcategory=2&newest=0&id=1&alemid=20s3");
      */
      break;
    }


  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text("Kategoriya Surady"),
      actions: [
        IconButton(
            icon: Icon(Icons.add_a_photo,color: Colors.white,),
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>
                    UploadProdImage(
                      editid: widget.editProd==null ?'': curProd.id,
                      type: widget.action=='addProduct'?'addProd':'editProd',


                    )),
              );
            })
      ],
      ),

      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(30.0),
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,

            children: <Widget>[
              CheckboxListTile(
                  title: Text('New'),
                  value: checkbox,
                  onChanged: (value){
                setState(() {
                 checkbox=!checkbox;
                });
              }),
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
              SizedBox(
                height: 20,
              ),
              Text('Descrip'),
              TextField(
                autofocus: false,
                maxLines: 4,
                controller: _tcd,
                onChanged: (txt){
                  setState(() {
                    defaultDesc=txt;
                  });
                },
              ),
              SizedBox(
                height: 20,
              ),
        Text('price'),
              TextField(
                autofocus: false,
                controller: _tcp,
                onChanged: (txt){
                  setState(() {
                    price=txt;
                  });
                },
              ),
              SizedBox(
                height: 20,
              ),
              Text('quantity'),
              TextField(
                autofocus: false,
                controller: _tcq,
                onChanged: (txt){
                  setState(() {
                    qunatity=txt;
                  });
                },
              ),
        DropdownButton(
               value: defaultGender,
                  items: widget.gender
                      .map<DropdownMenuItem<String>>((ProductTypes value) {
                    return DropdownMenuItem<String>(
                      value: value.name,
                      child: Text(value.name),
                    );
                  }).toList(),
                  onChanged: (String value){
                    setState(() {
                      defaultGender=value;
                      print(value);
                    });
                  }),
              DropdownButton(
                  value: defaultBrand,
                  items: widget.brands
                      .map<DropdownMenuItem<String>>((ProductTypes value) {
                    return DropdownMenuItem<String>(
                      value: value.name,
                      child: Text(value.name),
                    );
                  }).toList(),
                  onChanged: (String value){
                    setState(() {
                      defaultBrand=value;
                      print(value);
                    });
                  }),
              DropdownButton(
                  value: defaultColor,
                  items: widget.colors
                      .map<DropdownMenuItem<String>>((ProductTypes value) {
                    return DropdownMenuItem<String>(
                      value: value.name,
                      child: Text(value.name),
                    );
                  }).toList(),
                  onChanged: (String value){
                    setState(() {
                      defaultColor=value;
                      print(value);
                    });
                  }),
              DropdownButton(
                  value: defaultStatus,
                  items: widget.status
                      .map<DropdownMenuItem<String>>((ProductTypes value) {
                    return DropdownMenuItem<String>(
                      value: value.name,
                      child: Text(value.name),
                    );
                  }).toList(),
                  onChanged: (String value){
                    setState(() {
                      defaultStatus=value;
                      print(value);
                    });
                  }),
              DropdownButton(
                  value: defaultSize,
                  items: widget.sizes
                      .map<DropdownMenuItem<String>>((Size value) {
                    return DropdownMenuItem<String>(
                      value: value.name,
                      child: Text(value.name),
                    );
                  }).toList(),
                  onChanged: (String value){
                    setState(() {
                      defaultSize=value;
                      print(value);
                    });
                  }),
              DropdownButton(
                  value: subcategory,
                  items: widget.subcategories
                      .map<DropdownMenuItem<String>>((SubCategoryObj value) {
                    return DropdownMenuItem<String>(
                      value: value.runame,
                      child: Text(value.runame),
                    );
                  }).toList(),
                  onChanged: (String value){
                    setState(() {
                      subcategory=value;
                      print(value);
                    });
                  }),
              RaisedButton(
                onPressed: (){
                  if(defaultName=='' || defaultDesc=='' || price == '' || qunatity ==''){
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
      ),
    );
  }
}
