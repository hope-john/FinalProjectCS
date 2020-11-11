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
                  return ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => InsidePage()));
                      },
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
                            '${showData[index]['cal'].toString()}  Cal  Perservring',
                          ),
                        ],
                      ),
                      title: Text(
                        new DateFormat.yMMMd().format(
                            DateTime.parse(showData[index]['timestamp'])),
                      ),
                      trailing: const Icon(Icons.chevron_right));
                },
                itemCount: showData.length);
          },
        ),
      ),
    );
  }
}

class InsidePage extends StatefulWidget {
  @override
  InsidePageState createState() => InsidePageState();
}

class InsidePageState extends State<InsidePage> {
  final LocalStorage storage = new LocalStorage('food_history');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(color: const Color(0x000000)),
      ),
    );
  }
}
