import 'package:flutter/material.dart';

class HistoryDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0x000000),
          iconTheme: IconThemeData(color: Colors.orangeAccent),
          title: Text("Detail",style: TextStyle(color: Colors.orangeAccent)
          ),
        ),
        body: Center(),
    );
  }
}

