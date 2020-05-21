import 'package:flutter/material.dart';
import 'main.dart';
void main() => runApp(History());
class History extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'History',
      home: Scaffold(
        appBar: AppBar(
          title: Text("History Page"),
backgroundColor: Colors.orangeAccent,
      ),
floatingActionButton: new FloatingActionButton(
  backgroundColor: Colors.orangeAccent,
child: new Icon(Icons.add_to_home_screen),
  onPressed: (){
    Navigator.push(context, MaterialPageRoute(builder: (context)=> MainPage()));
  },



),
      ),
    );
  }
}
