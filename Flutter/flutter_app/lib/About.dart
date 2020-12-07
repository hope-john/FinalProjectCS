import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutPage extends StatelessWidget {
  static const routeName = "/about";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('About'),
        backgroundColor: Colors.orangeAccent,
      ),
      body: HomeContent(),
    );
  }
}

class HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget titleSection = new Container(
      padding: const EdgeInsets.all(32.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Text('Food Tracker',
                      style: GoogleFonts.lato(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.orangeAccent)),
                ),
                Text('Estimate calrories from internet',
                    style: GoogleFonts.lato(
                        fontSize: 18, color: Colors.orangeAccent)),
              ],
            ),
          ),
        ],
      ),
    );
    Widget buttonSection = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      ),
    );
    Widget textSection = Container(
      padding: EdgeInsets.fromLTRB(24, 5, 24, 5),
      child: Text(
        'Food Tracker aims to estimate calories from Thai street food by CNN and perform the estimation calorie from the average dish size from the internet.',
        softWrap: true,
      ),
    );
    Widget ReferSection = Container(
      padding: const EdgeInsets.all(24.0),
      child: Text(
        'Our References \n https://www.calforlife.com \n https://www.lovefitt.com \n https://www.nutritionix.com \n https://www.fatnever.com/calories \n https://www.wongnai.com',
        style: GoogleFonts.lato(
            fontSize: 18,
            color: Colors.orangeAccent,
            fontWeight: FontWeight.bold),
      ),
    );

    return ListView(
      children: <Widget>[
        Image(
          image: AssetImage('assets/food_bg3.jpg'),
          height: 220.0,
          fit: BoxFit.cover,
        ),
        titleSection,
        buttonSection,
        textSection,
        ReferSection,
      ],
    );
  }
}
