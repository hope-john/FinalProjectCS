import 'package:flutter/material.dart';
import 'Camera_page.dart';
import 'History.dart';


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
        title: Text('FOOD TRACKER'),
        backgroundColor: Colors.orangeAccent,
      ),
      
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/food_bg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              textColor: Colors.white,
              color: Colors.orangeAccent,
              child: Text('Go to pick image'),
              onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) =>  MyImagePicker()));

              },
            ),
            RaisedButton(
              textColor: Colors.white,
              color: Colors.orangeAccent,
              child: Text('History Page'),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => HistoryPage()));
              },
            )
          ],
        ),
      ),
    );
  }
}
