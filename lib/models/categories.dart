import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class CategoryObject with ChangeNotifier{
  String id;
  String name;
  String runame;
  CategoryObject({
    @required this.id,
    @required this.name,
    @required this.runame,

  });
  factory CategoryObject.fromJson(Map<String,dynamic> json){
    return CategoryObject(
      id: json['id'] as String,
      name: json['name'] as String,
      runame: json['runame'] as String,
    );
  }
}
class SubCategoryObject with ChangeNotifier{
  String id;
  String name;
  String runame;
  String supcategory;
  SubCategoryObject({
    @required this.id,
    @required this.name,
    @required this.runame,
    @required this.supcategory,

  });
  factory SubCategoryObject.fromJson(Map<String,dynamic> json){
    return SubCategoryObject(
      id: json['id'] as String,
      name: json['name'] as String,
      runame: json['runame'] as String,
      supcategory: json['supcategory'] as String,
    );
  }
}
class SubCategoryObj with ChangeNotifier{
  String id;
  String name;
  String runame;
  String category;
  SubCategoryObj({
    @required this.id,
    @required this.name,
    @required this.runame,
    @required this.category,

  });
  factory SubCategoryObj.fromJson(Map<String,dynamic> json){
    return SubCategoryObj(
      id: json['id'] as String,
      name: json['name'] as String,
      runame: json['runame'] as String,
      category: json['category'] as String,
    );
  }
}
class Categories with ChangeNotifier{
  List<CategoryObject> _categories=[];

  List<CategoryObject> get categories{
    return [..._categories];
  }
  List<SubCategoryObject> _subCategories=[];

  List<SubCategoryObject> get subCategories{
    return [..._subCategories];
  }



  CategoryObject getById(String id){
    return _categories.firstWhere((element) => element.id==id);
  }
  List<SubCategoryObj> _subCategory=[];

  List<SubCategoryObj> get subCategory{
    return [..._subCategory];
  }
  SubCategoryObject getByIdSub(String id){
    return _subCategories.firstWhere((element) => element.id==id);
  }
  SubCategoryObject getSubCatByName (String name){
    return _subCategories.firstWhere((element) => element.runame==name);
  }
  SubCategoryObj getCatByName (String name){
    return _subCategory.firstWhere((element) => element.runame==name);
  }
  Future <void> getCategories ()async{
    const url ='https://www.alemshop.com.tm/alem?table=supcategory';
    const urlC ='https://www.alemshop.com.tm/alem?table=category';
    const urlS ='https://www.alemshop.com.tm/alem?table=subcategory';

    try{
      final response= await http.get(url);

      final parsed=jsonDecode(response.body).cast<Map<String,dynamic>>();
      _categories= parsed.map<CategoryObject>((json)=>CategoryObject.fromJson(json)).toList();

      final responseC= await http.get(urlC);

      final parsedC=jsonDecode(responseC.body).cast<Map<String,dynamic>>();
      _subCategories= parsedC.map<SubCategoryObject>((json)=>SubCategoryObject.fromJson(json)).toList();

      final responseS= await http.get(urlS);

      final parsedS=jsonDecode(responseS.body).cast<Map<String,dynamic>>();
      _subCategory= parsedS.map<SubCategoryObj>((json)=>SubCategoryObj.fromJson(json)).toList();

      notifyListeners();
    }catch(error){
      throw(error);
    }

  }
  Future <void> getSubCategories ()async{
    const url ='https://www.alemshop.com.tm/alem?table=category';

    try{
      final response= await http.get(url);

      final parsed=jsonDecode(response.body).cast<Map<String,dynamic>>();
      _subCategories= parsed.map<SubCategoryObject>((json)=>SubCategoryObject.fromJson(json)).toList();

      notifyListeners();
    }catch(error){
      throw(error);
    }

  }
  Future <void> getSubCategory ()async{
    const url ='https://www.alemshop.com.tm/alem?table=subcategory';

    try{
      final response= await http.get(url);

      final parsed=jsonDecode(response.body).cast<Map<String,dynamic>>();
      _subCategory= parsed.map<SubCategoryObj>((json)=>SubCategoryObj.fromJson(json)).toList();

      notifyListeners();
    }catch(error){
      throw(error);
    }

  }

}