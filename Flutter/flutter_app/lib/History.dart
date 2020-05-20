import 'package:flutter/material.dart';
void main() => runApp(App());
class App extends StatelessWidget {
  
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
    onPressed: null,
child: new Icon(Icons.add_to_home_screen),
  backgroundColor: Colors.orangeAccent,
),
      ),
    );
  }
}
