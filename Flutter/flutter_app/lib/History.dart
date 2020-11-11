import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:intl/intl.dart';
import 'main.dart';
import 'dart:io';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'dart:async';
import 'package:infinite_listview/infinite_listview.dart';

class HistoryPage extends StatefulWidget {
  @override
  HistoryPageState createState() => HistoryPageState();
}

class HistoryPageState extends State<HistoryPage> {
  final LocalStorage storage = new LocalStorage('food_history');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("History Page"),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Center(
        child: FutureBuilder(
          builder: (BuildContext context, snapshot) {
            List showData = storage.getItem('foods');
            if (showData == null) {
              showData = [];
              storage.setItem('foods', showData);
            }
            print(showData[0]['cal']);
            return ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      if (index == 0)
                        Divider(
                          color: Colors.grey,
                        ),
                      ListTile(
                        subtitle: Row(
                          children: [
                            Text(
                              showData[index]['NameFood'].toString(),
                            ),
                            SizedBox(
                              width: 7,
                            ),
                            Text(
                              // showData[index]['cal'].toString(),
                              '${showData[index]['cal'].toString()} Cal Per-severing',
                            ),
                            SizedBox(
                              width: 7,
                            ),
                            Text(
                              DateFormat.Hm().format(
                                  DateTime.parse(showData[index]['timestamp'])),
                            ),
                          ],
                        ),
                        title: Text(
                          new DateFormat.yMMMd().format(
                              DateTime.parse(showData[index]['timestamp'])),
                        ),
                        trailing: buildIcon(int.parse(DateFormat.H().format(
                        DateTime.parse(showData[index]['timestamp'])))),
                        
                        // trailing: int.parse(DateFormat.H().format(
                        //             DateTime.parse(
                        //                 showData[index]['timestamp']))) <
                        //         12
                        //     ? Icon(Icons.brightness_low,
                        //         color: Colors.orangeAccent)
                        //     : Icon(
                        //         Icons.brightness_2,
                        //         color: Colors.yellow[700],
                        //       ),
                      ),
                      Divider(
                        color: Colors.grey,
                      ),
                    ],
                  );
                },
                itemCount: showData.length);
          },
        ),
      ),
    );
  }

  Widget buildIcon(int hour) {
    if (hour >= 6 && hour <= 12) {
      return Icon(Icons.brightness_low, color: Colors.orangeAccent);
    } else if (hour >= 13 && hour <= 18) {
      return Icon(Icons.flare, color: Colors.red ,size: 34 ,);
    } else {
      return Icon(
        Icons.brightness_2,
        color: Colors.yellow,
        // color: Colors.yellow[700],
      );
    }
  }
}
