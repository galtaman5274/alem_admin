import 'package:flutter/material.dart';

class CheckBoxList extends StatefulWidget {
  final String title;
  CheckBoxList(this.title);
  @override
  _CheckBoxListState createState() => _CheckBoxListState();
}

class _CheckBoxListState extends State<CheckBoxList> {
  bool isChecked=false;
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(

      dense: false,
    title: Text(widget.title),
    value: isChecked,
    onChanged: (value){
      setState(() {
        isChecked=value;
      });
    },
    );
  }
}
