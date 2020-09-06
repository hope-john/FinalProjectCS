import 'package:flutter/material.dart';
import 'main.dart';


class History {
  String data;
  DateTime dateTime;

  History({this.data, this.dateTime});
}
class HistoryPage extends StatefulWidget {
  @override
  HistoryPageState createState() => HistoryPageState();
}

class HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              })),
      body: ListView.builder(
        itemCount: historyList.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(
                ' ${historyList[index].data}   ${historyList[index].dateTime.toString()}'),
          );
        },
      ),
    );
  }
}