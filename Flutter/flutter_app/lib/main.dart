import 'package:flutter/material.dart';
import 'Camera_page.dart';
import 'History.dart';
import 'About.dart';

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
    final mediaWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('FOOD TRACKER'),
        backgroundColor: Colors.orangeAccent,
        
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0x000000)
        ),
        
      

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

          Container(
          height: 210,
          width: mediaWidth*0.7,
          decoration: new BoxDecoration(
  image: new DecorationImage(
      image: ExactAssetImage('assets/Icon_Trans.png'),
      fit: BoxFit.cover,
      ), 
        ),
),



          Container(
            width: mediaWidth * 0.7,
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                          elevation: 5,
              textColor: Colors.white,
              padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
              color: Colors.orangeAccent,
              
              child: Text('Go to pick image'),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyImagePicker()));
              },
            ),
          ),
          SizedBox(
                  height: 15,
                ),
          Container(
            width: mediaWidth * 0.7,
            child:RaisedButton(
              shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                          elevation: 5,
              textColor: Colors.white,
              padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
              color: Colors.orangeAccent,
              child: Text('History Page'),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HistoryPage()));
              },
            ),
          ),
          SizedBox(
                  height: 15,
                ),
          Container(
            width: mediaWidth * 0.7,
            child:RaisedButton(
              shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                          elevation: 5,
              textColor: Colors.white,
              padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
              color: Colors.orangeAccent,
              child: Text('About Food Tracker'),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AboutPage()));
              },
            )
          )
          ],
        ),
      ),
    );
  }
}
