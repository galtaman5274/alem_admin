import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class Product with ChangeNotifier{
  String id;
  String name;
  String descrip;
  String price;
  String quantity;
  String brand;
  String gender;
  String color;
  String status;
  String size;
  String subcategory;
  String newest;
  String alemid;
  Product({
    @required this.id,
    @required this.name,
    @required this.descrip,
    @required this.price,
  @required this.subcategory,
  @required this.size,
  @required this.status,
  @required this.color,
  @required this.gender,
  @required this.brand,
  @required this.newest,
  @required this.quantity,
  @required this.alemid

  });
  factory Product.fromJson(Map<String,dynamic> json){
    return Product(
      id: json['id'] as String,
      name: json['name'] as String,
      descrip: json['descrip'] as String,
      price: json['price'] as String,
      color: json['color'] as String,
      brand: json['brand'] as String,
      gender: json['gender'] as String,
      newest: json['newest'] as String,
      quantity: json['quantity'] as String,
      size: json['size'] as String,
      status: json['status'] as String,
      subcategory: json['subcategory'] as String,
      alemid: json['alemid'] as String,
    );
  }
}
class ProductTypes with ChangeNotifier{
  String id;
  String name;

  ProductTypes({
    @required this.id,
    @required this.name,


  });
  factory ProductTypes.fromJson(Map<String,dynamic> json){
    return ProductTypes(
      id: json['id'] as String,
      name: json['name'] as String,
     );
  }
}
class Size with ChangeNotifier{
  String id;
  String name;
  String category;

  Size({
    @required this.id,
    @required this.name,
    @required this.category,


  });
  factory Size.fromJson(Map<String,dynamic> json){
    return Size(
      id: json['id'] as String,
      name: json['name'] as String,
      category: json['category'] as String,
    );
  }
}
class Products with ChangeNotifier{
  List<Product> _products=[];

  List<Product> get products{
    return [..._products];
  }
  Product prodById(String id){
    return _products.firstWhere((element) => element.id==id);
  }
  Product prodByName(String name){
    return _products.firstWhere((element) => element.name==name);
  }
  List <Product> getNewest(){
    return[..._products.where((e) => e.newest=='1').toList()];
  }
  List<ProductTypes> _brands=[];

  List<ProductTypes> get brands{
    return [..._brands];
  }
  ProductTypes brandByName(String name){
    return _brands.firstWhere((element) => element.name==name);
  }
  List<ProductTypes> _color=[];

  List<ProductTypes> get color{
    return [..._color];
  }
  ProductTypes colorByName(String name){
    return _color.firstWhere((element) => element.name==name);
  }
  List<ProductTypes> _status=[];

  List<ProductTypes> get status{
    return [..._status];
  }
  ProductTypes statusByName(String name){
    return _status.firstWhere((element) => element.name==name);
  }
  List<ProductTypes> _gender=[];

  List<ProductTypes> get gender{
    return [..._gender];
  }
  ProductTypes genderByName(String name){
    return _gender.firstWhere((element) => element.name==name);
  }
  List<Size> _size=[];

  List<Size> get size{
    return [..._size];
  }
  Size sizeByName(String name){
    return _size.firstWhere((element) => element.name==name);
  }
  List<ProductTypes>  types(String type){
    List<ProductTypes> types;
    switch(type){
      case 'gender':
        types=_gender;
        break;
      case 'brands':
        types=_brands;
        break;
      case 'colors':
        types=_color;
        break;
      case 'status':
        types=_status;
        break;
      case 'sizes':
       // types=_size;
        break;
    }
    return [...types];
  }
  Product getByIdSub(String id){
    return _products.firstWhere((element) => element.id==id);
  }
  Future <void> getProducts ()async{
    const urlProd ='https://www.alemshop.com.tm/alem?table=products';
    const urlGender ='https://www.alemshop.com.tm/alem?table=gender';
    const urlBrand ='https://www.alemshop.com.tm/alem?table=brands';
    const urlColor ='https://www.alemshop.com.tm/alem?table=color';
    const urlStatus ='https://www.alemshop.com.tm/alem?table=status';
    const urlSize ='https://www.alemshop.com.tm/alem?table=size';
     try{
      final responseProd= await http.get(urlProd);
        final parsedProd=jsonDecode(responseProd.body).cast<Map<String,dynamic>>();
      _products= parsedProd.map<Product>((json)=>Product.fromJson(json)).toList();

      final responseGender= await http.get(urlGender);
      final parsedGender=jsonDecode(responseGender.body).cast<Map<String,dynamic>>();
      _gender= parsedGender.map<ProductTypes>((json)=>ProductTypes.fromJson(json)).toList();

      final responseBrand= await http.get(urlBrand);
      final parsedBrand=jsonDecode(responseBrand.body).cast<Map<String,dynamic>>();
      _brands= parsedBrand.map<ProductTypes>((json)=>ProductTypes.fromJson(json)).toList();

      final responseColor= await http.get(urlColor);
      final parsedColor=jsonDecode(responseColor.body).cast<Map<String,dynamic>>();
      _color= parsedColor.map<ProductTypes>((json)=>ProductTypes.fromJson(json)).toList();

      final responseStatus= await http.get(urlStatus);

      final parsedStatus=jsonDecode(responseStatus.body).cast<Map<String,dynamic>>();
      _status= parsedStatus.map<ProductTypes>((json)=>ProductTypes.fromJson(json)).toList();

      final responseSize= await http.get(urlSize);

      final parsedSize=jsonDecode(responseSize.body).cast<Map<String,dynamic>>();
      _size= parsedSize.map<Size>((json)=>Size.fromJson(json)).toList();

      notifyListeners();
    }catch(error){
      throw(error);
    }

  }
  Future <void> getGender ()async{

    const urlGender ='https://www.alemshop.com.tm/alem?table=gender';


    try{
      final responseGender= await http.get(urlGender);
      final parsedGender=jsonDecode(responseGender.body).cast<Map<String,dynamic>>();
      _gender= parsedGender.map<ProductTypes>((json)=>ProductTypes.fromJson(json)).toList();

      notifyListeners();
    }catch(error){
      throw(error);
    }

  }
  Future <void> getBrands ()async{
  const urlBrand ='https://www.alemshop.com.tm/alem?table=brands';
     try{

      final responseBrand= await http.get(urlBrand);
          final parsedBrand=jsonDecode(responseBrand.body).cast<Map<String,dynamic>>();
      _brands= parsedBrand.map<ProductTypes>((json)=>ProductTypes.fromJson(json)).toList();
       notifyListeners();
    }catch(error){
      throw(error);
    }

  }
  Future <void> getColors ()async{
    const urlColor ='https://www.alemshop.com.tm/alem?table=color';
    try{
      final responseColor= await http.get(urlColor);
      final parsedColor=jsonDecode(responseColor.body).cast<Map<String,dynamic>>();
      _color= parsedColor.map<ProductTypes>((json)=>ProductTypes.fromJson(json)).toList();
       notifyListeners();
    }catch(error){
      throw(error);
    }

  }
  Future <void> getStatus ()async{
      const urlStatus ='https://www.alemshop.com.tm/alem?table=status';
      try{
      final responseStatus= await http.get(urlStatus);

     final parsedStatus=jsonDecode(responseStatus.body).cast<Map<String,dynamic>>();
      _status= parsedStatus.map<ProductTypes>((json)=>ProductTypes.fromJson(json)).toList();

      notifyListeners();
    }catch(error){
      throw(error);
    }

  }
  Future <void> getSize ()async{
      const urlSize ='https://www.alemshop.com.tm/alem?table=size';
      /*HttpServer.bind('127.0.0.1', 8080).then((server){
        server.listen((HttpRequest request){
          request.uri.queryParameters.forEach((param,val){
            print(param + '-' + val);
          });

          request.response.headers.add("Access-Control-Allow-Origin", "*");
          request.response.headers.add("Access-Control-Allow-Methods", "POST,GET,DELETE,PUT,OPTIONS");

          request.response.statusCode = HttpStatus.ok;
          request.response.write("Success!");
          request.response.close();
        });
      });*/
    try{

      final responseSize= await http.get(urlSize);

        final parsedSize=jsonDecode(responseSize.body).cast<Map<String,dynamic>>();
       _size= parsedSize.map<Size>((json)=>Size.fromJson(json)).toList();

      notifyListeners();
    }catch(error){
      throw(error);
    }

  }


}
