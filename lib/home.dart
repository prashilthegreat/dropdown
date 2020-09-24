import 'package:flutter/material.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var stationNameList = List();
  var stationIDList = List();
  var isSelected = false;
  Future getData() async {
    final url = "http://purba.buzzmedianepal.com/api";
    var latitude = 27.6840464992;
    var longitude = 85.3405647029;
    var nearestStationsList;
    var response = await http.get("$url/index", headers: {
      "x-header-latitude": "$latitude",
      "x-header-longitude": "$longitude"
    });
    if (response.statusCode == 200) {
      var map = jsonDecode(response.body);
      nearestStationsList = map['nearest_stations'];
      for (var item in nearestStationsList) {
        print(item['station_name']);
        setState(() {
          stationNameList.add(item['station_name']);
          stationIDList.add(item['station_id']);
        });
      }
      return stationNameList;
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
            isCaseSensitiveSearch: false,
            items: stationNameList.map((item) {
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
