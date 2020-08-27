import 'package:alem_admin/lib/models/subcategory.dart';
import 'package:alem_admin/lib/widgets/checkbox_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class SingleScrollView extends StatefulWidget {
  final List<Widget> imageSliders;
  final List<Subcategory> loadedProductList;
  final List<CheckBoxList> colorTypes;
  final List<CheckBoxList> sizeTypes;

  SingleScrollView({Key key, this.loadedProductList,this.imageSliders,this.colorTypes,this.sizeTypes}):super(key:key);
  @override
  _SingleScrollViewState createState() => _SingleScrollViewState();
}

class _SingleScrollViewState extends State<SingleScrollView> {
  int _current=0;
  String selColor;
  String selSize;




  @override
  Widget build(BuildContext context) {


    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          CarouselSlider(
            items: widget.imageSliders,
            options: CarouselOptions(
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio:1.0,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                }
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.loadedProductList.map((url) {
              int index = widget.loadedProductList.indexOf(url);
              return Container(
                width: 8.0,
                height: 8.0,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _current == index
                      ? Color.fromRGBO(0, 0, 0, 0.9)
                      : Color.fromRGBO(0, 0, 0, 0.4),
                ),
              );
            }).toList(),
          ),
          Divider(
            height: 20,
            color: Colors.black,
          ),
          Row(
            children: <Widget>[
              Expanded(child: Text('Color')),
              Expanded(child: Text('Size')),


            ],
          ),

          Row(
            children: <Widget>[
           Expanded(
             child: Column(
               mainAxisAlignment: MainAxisAlignment.start,
               children: widget.colorTypes,

             ),
           ),
           Expanded(
             child: Column(
               mainAxisAlignment: MainAxisAlignment.start,
               children:widget.sizeTypes ,

                ),
              ),

            ],
          ),

          Container(
            alignment: Alignment.centerLeft,
            child: Text('Descp'),
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Text('Descp'),
          ),
        ],
      ),
    );
  }
}
