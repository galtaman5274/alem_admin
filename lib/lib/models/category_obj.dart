
import 'package:flutter/material.dart';

class CategoryObject with ChangeNotifier{
  String id;
  String name;
  String routeName;
  CategoryObject({
    @required this.id,
    @required this.name,
    @required this.routeName,

});
  factory CategoryObject.fromJson(Map<String,dynamic> json){
    return CategoryObject(
      id: json['id'] as String,
      name: json['name'] as String,
      routeName: json['routeName'] as String,
    );
  }
}