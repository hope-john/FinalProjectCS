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

            return ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HistorySecondPage()));
                      },
                      subtitle: Text(showData[index]['NameFood']),
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

class HistorySecondPage extends StatefulWidget {
  @override
  HistoryPageState createState() => HistoryPageState();
}

class HistorySecondPageState extends State<HistorySecondPage> {
  final LocalStorage storage = new LocalStorage('food_history');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/yellow_bg.jpg'),
                fit: BoxFit.cover,
              ),
            )));
  }
}
