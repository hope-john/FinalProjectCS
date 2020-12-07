import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:localstorage/localstorage.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';
import 'dart:convert';
import 'package:intl/intl.dart';

class HistoryDetailScreen extends StatefulWidget {
  static const routeName = "/history-detail";
  @override
  HistoryDetailScreenState createState() => HistoryDetailScreenState();
}

enum LegendShape { Circle, Rectangle }

class HistoryDetailScreenState extends State<HistoryDetailScreen> {
  final LocalStorage storage = new LocalStorage('food_history');

  static minus(a, b) {
    return a - b;
  }

  static dynamic calc = 1050;

  int _currentIndex = 0;
  List<Color> colorList = [
    Colors.grey,
    Colors.orange,
    //Colors.blue,
    //Colors.orange,
  ];
  ChartType _chartType = ChartType.ring;
  bool _showCenterText = true;
  double _ringStrokeWidth = 16;
  double _chartLegendSpacing = 32;

  bool _showLegendsInRow = false;
  bool _showLegends = true;

  bool _showChartValueBackground = true;
  bool _showChartValues = true;
  bool _showChartValuesInPercentage = true;
  bool _showChartValuesOutside = false;

  LegendShape _legendShape = LegendShape.Circle;
  LegendPosition _legendPosition = LegendPosition.right;

  int key = 0;
  @override
  Widget build(
    BuildContext context,
  ) {
    final preservedCal = ModalRoute.of(context).settings.arguments as int;
    List showData = storage.getItem('foods');
    if (showData == null) {
      showData = [];
      storage.setItem('foods', showData);
      return CircularProgressIndicator();
    } else {
      showData = showData.reversed.toList();
      print(showData[0]['cal'].runtimeType);
      //return Scaffold(
      //appBar: AppBar(
      //elevation: 0,
      //backgroundColor: Color(0x000000),
      //iconTheme: IconThemeData(color: Colors.orangeAccent),
      //title: Text("Detail",style: TextStyle(color: Colors.orangeAccent)
      //),
      //),
      //body: Center(

      //),

      //);

      final chart = PieChart(
        key: ValueKey(key),
        dataMap: {
          "Limit-left": minus(650, preservedCal).toDouble(),
          "Calories": preservedCal.toDouble(),
        },
        animationDuration: Duration(milliseconds: 800),
        chartLegendSpacing: _chartLegendSpacing,
        chartRadius: MediaQuery.of(context).size.width / 3.2 > 300
            ? 300
            : MediaQuery.of(context).size.width / 3.2,
        colorList: colorList,
        initialAngleInDegree: 0,
        chartType: _chartType,
        centerText: _showCenterText ? "CAL-PER-MEAL" : null,
        legendOptions: LegendOptions(
          showLegendsInRow: _showLegendsInRow,
          legendPosition: _legendPosition,
          showLegends: _showLegends,
          legendShape: _legendShape == LegendShape.Circle
              ? BoxShape.circle
              : BoxShape.rectangle,
          legendTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        chartValuesOptions: ChartValuesOptions(
          showChartValueBackground: _showChartValueBackground,
          showChartValues: _showChartValues,
          showChartValuesInPercentage: _showChartValuesInPercentage,
          showChartValuesOutside: _showChartValuesOutside,
        ),
        ringStrokeWidth: _ringStrokeWidth,
      );
      final settings = SingleChildScrollView(
        child: Card(
          margin: EdgeInsets.all(12),
          child: Column(
            children: [
              ListTile(
                title: Text(
                  'Pie Chart Options'.toUpperCase(),
                  style: Theme.of(context).textTheme.overline.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              ListTile(
                title: Text("chartType"),
                trailing: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: DropdownButton<ChartType>(
                    value: _chartType,
                    items: [
                      DropdownMenuItem(
                        child: Text("disc"),
                        value: ChartType.disc,
                      ),
                      DropdownMenuItem(
                        child: Text("ring"),
                        value: ChartType.ring,
                      ),
                    ],
                    onChanged: (val) {
                      setState(() {
                        _chartType = val;
                      });
                    },
                  ),
                ),
              ),
              ListTile(
                title: Text("ringStrokeWidth"),
                trailing: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: DropdownButton<double>(
                    value: _ringStrokeWidth,
                    disabledHint: Text("select chartType.ring"),
                    items: [
                      DropdownMenuItem(
                        child: Text("16"),
                        value: 16,
                      ),
                      DropdownMenuItem(
                        child: Text("32"),
                        value: 32,
                      ),
                      DropdownMenuItem(
                        child: Text("48"),
                        value: 48,
                      ),
                    ],
                    onChanged: (_chartType == ChartType.ring)
                        ? (val) {
                            setState(() {
                              _ringStrokeWidth = val;
                            });
                          }
                        : null,
                  ),
                ),
              ),
              SwitchListTile(
                value: _showCenterText,
                title: Text(
                  "showCenterText",
                ),
                activeColor: Colors.orangeAccent,
                onChanged: (val) {
                  setState(() {
                    _showCenterText = val;
                  });
                },
              ),
              ListTile(
                title: Text("chartLegendSpacing",
                    style: TextStyle(color: Colors.orangeAccent)),
                trailing: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: DropdownButton<double>(
                    value: _chartLegendSpacing,
                    disabledHint: Text("select chartType.ring"),
                    items: [
                      DropdownMenuItem(
                        child: Text("16"),
                        value: 16,
                      ),
                      DropdownMenuItem(
                        child: Text("32"),
                        value: 32,
                      ),
                      DropdownMenuItem(
                        child: Text("48"),
                        value: 48,
                      ),
                      DropdownMenuItem(
                        child: Text("64"),
                        value: 64,
                      ),
                    ],
                    onChanged: (val) {
                      setState(() {
                        _chartLegendSpacing = val;
                      });
                    },
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  'Legend Options'.toUpperCase(),
                  style: Theme.of(context).textTheme.overline.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              SwitchListTile(
                value: _showLegendsInRow,
                title: Text("showLegendsInRow"),
                activeColor: Colors.orangeAccent,
                onChanged: (val) {
                  setState(() {
                    _showLegendsInRow = val;
                  });
                },
              ),
              SwitchListTile(
                value: _showLegends,
                title: Text("showLegends"),
                activeColor: Colors.orangeAccent,
                onChanged: (val) {
                  setState(() {
                    _showLegends = val;
                  });
                },
              ),
              ListTile(
                title: Text("legendShape"),
                trailing: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: DropdownButton<LegendShape>(
                    value: _legendShape,
                    items: [
                      DropdownMenuItem(
                        child: Text("BoxShape.circle"),
                        value: LegendShape.Circle,
                      ),
                      DropdownMenuItem(
                        child: Text("BoxShape.rectangle"),
                        value: LegendShape.Rectangle,
                      ),
                    ],
                    onChanged: (val) {
                      setState(() {
                        _legendShape = val;
                      });
                    },
                  ),
                ),
              ),
              ListTile(
                title: Text("legendPosition"),
                trailing: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: DropdownButton<LegendPosition>(
                    value: _legendPosition,
                    items: [
                      DropdownMenuItem(
                        child: Text("left"),
                        value: LegendPosition.left,
                      ),
                      DropdownMenuItem(
                        child: Text("right"),
                        value: LegendPosition.right,
                      ),
                      DropdownMenuItem(
                        child: Text("top"),
                        value: LegendPosition.top,
                      ),
                      DropdownMenuItem(
                        child: Text("bottom"),
                        value: LegendPosition.bottom,
                      ),
                    ],
                    onChanged: (val) {
                      setState(() {
                        _legendPosition = val;
                      });
                    },
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  'Chart values Options'.toUpperCase(),
                  style: Theme.of(context).textTheme.overline.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              SwitchListTile(
                value: _showChartValueBackground,
                title: Text("showChartValueBackground"),
                activeColor: Colors.orangeAccent,
                onChanged: (val) {
                  setState(() {
                    _showChartValueBackground = val;
                  });
                },
              ),
              SwitchListTile(
                value: _showChartValues,
                title: Text("showChartValues"),
                activeColor: Colors.orangeAccent,
                onChanged: (val) {
                  setState(() {
                    _showChartValues = val;
                  });
                },
              ),
              SwitchListTile(
                value: _showChartValuesInPercentage,
                activeColor: Colors.orangeAccent,
                title: Text("showChartValuesInPercentage"),
                onChanged: (val) {
                  setState(() {
                    _showChartValuesInPercentage = val;
                  });
                },
              ),
              SwitchListTile(
                value: _showChartValuesOutside,
                title: Text("showChartValuesOutside"),
                activeColor: Colors.orangeAccent,
                onChanged: (val) {
                  setState(() {
                    _showChartValuesOutside = val;
                  });
                },
              ),
            ],
          ),
        ),
      );
      return Scaffold(
        appBar: AppBar(
          title: Text("Detail", style: TextStyle(color: Colors.orangeAccent)),
          elevation: 0,
          backgroundColor: Color(0x000000),
          iconTheme: IconThemeData(color: Colors.orangeAccent),
          actions: [
            RaisedButton(
              onPressed: () {
                setState(() {
                  key = key + 1;
                });
              },
              child: Text("Reload".toUpperCase()),
            ),
          ],
        ),
        body: LayoutBuilder(
          builder: (_, constraints) {
            if (constraints.maxWidth >= 600) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 2,
                    fit: FlexFit.tight,
                    child: chart,
                  ),
                  Flexible(
                    flex: 1,
                    child: settings,
                  )
                ],
              );
            } else {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      child: chart,
                      margin: EdgeInsets.symmetric(
                        vertical: 32,
                      ),
                    ),
                    settings,
                  ],
                ),
              );
            }
          },
        ),
      );
    }
  }
}
