import 'package:flutter/material.dart';
import 'package:flutterapp/History_Detail_screen.dart';
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
              return CircularProgressIndicator();
            } else {
              showData = showData.reversed.toList();
              print(showData[0]['cal'].runtimeType);
              return ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HistoryDetailScreen())),
                      child: Column(
                        children: [
                          if (index == 0)
                            Divider(color: Colors.orangeAccent, thickness: 0.8),
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
                                  DateFormat.Hm().format(DateTime.parse(
                                      showData[index]['timestamp'])),
                                ),
                              ],
                            ),
                            title: Text(
                              new DateFormat.yMMMd().format(
                                  DateTime.parse(showData[index]['timestamp'])),
                            ),
                            trailing: buildIcon(int.parse(DateFormat.H().format(
                                DateTime.parse(showData[index]['timestamp'])))),

                            leading: CircleAvatar(
                                backgroundColor: Colors.orangeAccent[100],
                                child: buildCalIcon(showData[index]['cal'])),

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
                          Divider(color: Colors.orangeAccent, thickness: 0.8),
                        ],
                      ),
                    );
                  },
                  itemCount: showData.length);
            }
            ;
          },
        ),
      ),
    );
  }

  Widget buildIcon(int hour) {
    if (hour >= 6 && hour <= 12) {
      return Icon(Icons.wb_twighlight, color: Colors.redAccent, size: 30);
    } else if (hour >= 13 && hour <= 18) {
      return Icon(Icons.wb_sunny, color: Colors.orangeAccent, size: 30);
    } else {
      return Icon(Icons.bedtime, color: Colors.yellow[600], size: 30
          // color: Colors.yellow[700],
          );
    }
  }

  Widget buildCalIcon(int cal) {
    if (cal < 450) {
      return Icon(Icons.restaurant, color: Colors.green, size: 25);
    } else {
      return Icon(Icons.restaurant, color: Colors.redAccent, size: 25);
    }
  }
}
