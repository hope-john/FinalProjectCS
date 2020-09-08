import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("History"),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Center(
        child: FutureBuilder(
          builder: (context, snapshot) {
            var showData = json.decode(snapshot.data.toString());
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  onTap: () {},
                  
                  title: Text(showData[index]['timestamp']),
                  subtitle: Text(showData[index]['department']),
                  trailing: const Icon(Icons.chevron_right),
                  
                );
              },
              itemCount: showData.length,
            );
          },
          future: DefaultAssetBundle.of(context).loadString("assets/food.json"),
        ),
      ),
    );
  }
}
