import 'package:flutter/material.dart';
void main() => runApp(App());
class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Navigation',
      home: MainPage(),
    );
  }
}
class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Page'),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              textColor: Colors.white,
              color: Colors.orangeAccent,
              child: Text('Go to Camera'),
              onPressed: () {
              },
            ),
            RaisedButton(
              textColor: Colors.white,
              color: Colors.orangeAccent,
              child: Text('History Page'),
              onPressed: (){},
            )
          ],
        ),
      ),
    );
  }
}
