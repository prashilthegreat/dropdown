import 'package:flutter/material.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var dataList = List();
  var isSelected = false;
  Future getData() async {
    final url =
        "https://raw.githubusercontent.com/prashilthegreat/jsonhoster/master/dummydata.json";
    var subjectList;
    final response = await http.get(url);
    if (response.statusCode == 200) {
      var map = jsonDecode(response.body);
      subjectList = map['data'];
      for (var item in subjectList) {
        setState(() {
          dataList.add(item['name']);
        });
      }
      return dataList;
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    var selectedValue;
    return Scaffold(
      appBar: AppBar(
        title: Text("Searchable Dropdown"),
      ),
      body: Center(
        child: Container(
          child: SearchableDropdown.single(
            hint: "Select any",
            underline: Container(),
            value: selectedValue,
            items: dataList.map((item) {
              return DropdownMenuItem(
                child: Text(item),
                value: item,
              );
            }).toList(),
            onChanged: (val) {
              selectedValue = val;
            },
          ),
        ),
      ),
    );
  }
}
