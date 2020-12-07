import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:localstorage/localstorage.dart';
import 'package:tflite/tflite.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';

class MyImagePicker extends StatefulWidget {
  static const routeName = "/camera-page";
  @override
  MyImagePickerState createState() => MyImagePickerState();
}

class MyImagePickerState extends State {
  final LocalStorage storage = new LocalStorage('food_history');
  double score = 0;
  File imageURI;
  String result;
  String path;
  Future getImageFromCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      imageURI = image;
      path = image.path;
    });
  }

  Future getImageFromGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageURI = image;
      path = image.path;
    });
  }

  void classifyImage(BuildContext context) async {
    List showData = storage.getItem('foods');
    if (showData == null) {
      showData = [];
      storage.setItem('foods', showData);
    }
    FormData formData =
        new FormData.fromMap({"file": await MultipartFile.fromFile(path)});
    try {
      var response =
          await Dio().post("http://172.20.10.3:5000/upload", data: formData);
      dynamic parsedJson = json.decode(response.data.toString());
      setState(() {
        result =
            "${parsedJson['class']}\nConfidence : ${parsedJson['score'].toStringAsFixed(2)} %\nCalorie ${parsedJson['calories']} Cal Per-serving";
        score = parsedJson['score'];
      });
      var iso8601string = new DateTime.now().toIso8601String();
      var newData = {
        "empname": "",
        "cal": parsedJson['calories'],
        "NameFood": parsedJson['class'],
        "timestamp": iso8601string
      };
      showData.add(newData);
      storage.setItem('foods', showData);
    } catch (e) {
      setState(() {
        result = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0x000000),
          iconTheme: IconThemeData(color: Colors.orangeAccent),
        ),
        body: SingleChildScrollView(
          child: Container(
              width: double.infinity,
              decoration: BoxDecoration(color: const Color(0x000000)),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    imageURI == null
                        ? Text('No image selected!',
                            style: GoogleFonts.lato(
                              color: Colors.orangeAccent,
                              fontSize: 32,
                            ))
                        : Image.file(imageURI,
                            width: mediaWidth * 0.7,
                            height: 224,
                            fit: BoxFit.cover),
                    Container(
                      width: mediaWidth * 0.7,
                      child: Divider(
                        color: Colors.orangeAccent,
                        thickness: 1.5,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                        width: mediaWidth * 0.7,
                        child: RaisedButton.icon(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          elevation: 5,
                          color: Colors.orangeAccent,
                          icon: Icon(Icons.add_a_photo),
                          onPressed: () => getImageFromCamera(),
                          label: Text('Take a Photo '),
                          textColor: Colors.white,
                          padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                        )),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                        width: mediaWidth * 0.7,
                        child: RaisedButton.icon(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          elevation: 5,
                          color: Colors.orangeAccent,
                          icon: Icon(Icons.add_photo_alternate),
                          onPressed: () => getImageFromGallery(),
                          label: Text('Select an Image '),
                          textColor: Colors.white,
                          padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                        )),
                    Container(
                        width: mediaWidth * 0.7,
                        margin: EdgeInsets.only(top: 15, bottom: 15),
                        child: RaisedButton.icon(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          elevation: 5,
                          onPressed: imageURI == null
                              ? null
                              : () => classifyImage(context),
                          icon: Icon(Icons.find_in_page),
                          label: Text('Scan'),
                          textColor: Colors.white,
                          color: Colors.orangeAccent,
                          padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                        )),
                    Container(
                      width: mediaWidth * 0.7,
                      child: Divider(
                        color: Colors.orangeAccent,
                        thickness: 1.5,
                      ),
                    ),
                    result == null
                        ? Text('Result',
                            style: GoogleFonts.lato(
                              color: Colors.orangeAccent,
                              fontSize: 29,
                            ))
                        : Container(
                            height: 130,
                            width: 325,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(result,
                                  style: GoogleFonts.lato(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold)),
                            ),
                            decoration: BoxDecoration(
                              color: Colors.orangeAccent,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                    SizedBox(
                      height: 12,
                    ),
                    score > 66
                        ? Icon(
                            Icons.check_box_rounded,
                            color: Colors.lightGreen[700],
                            size: 45,
                          )
                        : score > 35
                            ? Icon(
                                Icons.check_box_rounded,
                                color: Colors.yellow[700],
                                size: 45,
                              )
                            : score > 1
                                ? Icon(
                                    Icons.error_outline_sharp,
                                    color: Colors.red,
                                    size: 45,
                                  )
                                : Material(),
                  ])),
        ));
  }
}
